package org.stoevesand.brain;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Vector;

import javax.faces.context.FacesContext;
import javax.faces.model.ListDataModel;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.jboss.logging.Logger;
import org.primefaces.model.UploadedFile;
import org.stoevesand.brain.exceptions.DBException;
import org.stoevesand.brain.model.Answer;
import org.stoevesand.brain.model.Item;
import org.stoevesand.brain.model.Lesson;

public class LessonLoader {

	private static Logger log = Logger.getLogger(LessonLoader.class);

	UploadedFile uploadedFile = null;

	Vector<Item> newItems = null;
	Vector<Item> modifiedItems = null;
	Vector<Item> removedItems = null;
	int numberUploadedItems = 0;
	private Boolean useLineNumbers = true;
	private boolean deleteRemovedItems = false;

	BrainSession session = null;

	public void downloadLesson(Lesson lesson) {
		HSSFWorkbook wb = new HSSFWorkbook();
		// Workbook wb = new XSSFWorkbook();
		// CreationHelper createHelper = wb.get getCreationHelper();
		HSSFSheet sheet = wb.createSheet("Lesson");

		// Create a row and put some cells in it. Rows are 0 based.
		Row firstrow = sheet.createRow((short) 0);
		firstrow.createCell(0).setCellValue("ID");
		firstrow.createCell(1).setCellValue("CH");
		firstrow.createCell(2).setCellValue("QU");
		firstrow.createCell(3).setCellValue("PH");
		firstrow.createCell(4).setCellValue("AN");

		// make sure the current version from db is read.
		lesson.reset();

		int rownum = 1;
		for (Item item : lesson.getItems()) {
			Row row = sheet.createRow(rownum++);
			row.createCell(0).setCellValue(item.getExtId());
			row.createCell(1).setCellValue(item.getChapter());
			row.createCell(2).setCellValue(item.getText());
			row.createCell(3).setCellValue(item.getComment());
			int colnum = 4;
			try {
				for (Answer answer : item.getAnswers()) {
					row.createCell(colnum).setCellValue(answer.getTextWithPhonetic());
					firstrow.createCell(colnum).setCellValue("AN");
					colnum++;
				}
			} catch (DBException e) {
				e.printStackTrace();
			}
		}

		FacesContext ctx = FacesContext.getCurrentInstance();

		if (!ctx.getResponseComplete()) {
			String fileName = "lesson.xls";
			String contentType = "application/vnd.ms-excel";

			HttpServletResponse response = (HttpServletResponse) ctx.getExternalContext().getResponse();
			response.setContentType(contentType);
			response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");

			ServletOutputStream out;
			try {
				out = response.getOutputStream();
				wb.write(out);
				out.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
			ctx.responseComplete();
		}
	}

	public boolean fileLessonUploaded(BrainSession session, Lesson lesson) {
		if (uploadedFile != null) {

			log.debug("f: " + uploadedFile.getContentType());
			log.debug("f: " + uploadedFile.getFileName());

			try {
				readNewItems(session, uploadedFile.getInputstream(), lesson);
				System.out.println("Successfully uploaded file " + uploadedFile.getFileName() + " (" + uploadedFile.getSize() + " bytes)");
				return true;
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		return false;
	}

	void readNewItems(BrainSession session, InputStream inputStream, Lesson lesson) {
		// if (fileFormat == 0)
		// readNewItemsText(inputStream);
		// else
		readNewItemsExcel(session, inputStream, lesson);
	}

	void readNewItemsExcel(BrainSession session, InputStream inputStream, Lesson lesson) {

		Lesson currentLesson = lesson;

		HashMap<String, Item> items = new HashMap<String, Item>();
		try {

			Vector<String> pattern = new Vector<String>(20);

			// nur auf chapter prüfen, wenn dies explizit übergeben wurde!
			boolean checkChapter = false;

			HSSFWorkbook wb = new HSSFWorkbook(new POIFSFileSystem(inputStream));

			HSSFSheet sheet1 = wb.getSheetAt(0);
			Iterator<Row> rowsIterator = sheet1.iterator();

			int cellsTotal = 0;

			if (rowsIterator.hasNext()) {
				Row row = rowsIterator.next();
				Iterator<Cell> cellsIterator = row.cellIterator();
				while (cellsIterator.hasNext()) {
					Cell cell = cellsIterator.next();
					if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
						String cellValue = cell.getRichStringCellValue().getString();
						pattern.add(cellValue);
						cellsTotal++;
					}

				}
			}
			// System.out.println("Pattern: " + pattern);

			while (rowsIterator.hasNext()) {
				Row row = rowsIterator.next();
				// Iterator cellsIterator = row.iterator();

				Item item = new Item();
				item.setLessonId(currentLesson.getId());
				item.setChapter(currentLesson.getHighestChapter() + 1);

				if (useLineNumbers.booleanValue()) {
					item.setExtId(row.getRowNum());
				}

				for (int cellnum = 0; cellnum < cellsTotal; cellnum++) {

					String cellValueString = "";
					long cellValueLong = 0;

					Cell cell = row.getCell(cellnum);

					if (cell != null) {
						switch (cell.getCellType()) {
						case Cell.CELL_TYPE_STRING:
							// System.out.println(cell.getRichStringCellValue().getString());
							cellValueString += cell.getRichStringCellValue().getString();
							break;
						case Cell.CELL_TYPE_NUMERIC:
							DecimalFormat myFormatter = new DecimalFormat();
							cellValueString = myFormatter.format( cell.getNumericCellValue() );
							cellValueLong = Math.round(cell.getNumericCellValue());
							break;
						case Cell.CELL_TYPE_BOOLEAN:
							// System.out.println(cell.getBooleanCellValue());
							cellValueString += cell.getBooleanCellValue();
							break;
						case Cell.CELL_TYPE_FORMULA:
							// System.out.println(cell.getCellFormula());
							cellValueString += cell.getCellFormula();
							break;
						default:
							// System.out.println();
						}
					}

					String coltype = getPattern(pattern, cellnum).toUpperCase();
					if ("QU".equals(coltype)) {
						item.setText(cellValueString);
					} else if ("CH".equals(coltype)) { // chapter
						item.setChapter((int) cellValueLong);
						checkChapter = true;
					} else if ("PH".equals(coltype)) { // phonetics
						item.setComment(cellValueString);
					} else if (("E".equals(coltype)) || ("ID".equals(coltype))) { // external
						// ID
						item.setExtId(cellValueLong);
					} else if ("AN".equals(coltype)) {
						String at = cellValueString;
						if ((at != null) && (at.trim().length() > 0)) {
							Answer answer = new Answer(at);
							item.addAnswer(answer);
						}
					} else {
						log.debug("Unknown import type: " + coltype);
					}
				}

				// wenn zweimal die gleiche Frage auftaucht, werden die Antworten
				// einfach rangehängt.
				String key = (item.getExtId() > 0) ? "" + item.getExtId() : item.getText();
				Item i2 = items.get(key);
				if (i2 != null) {
					i2.getAnswers().addAll(item.getAnswers());
					item = i2;
				}
				items.put(key, item);

			}

			newItems = new Vector<Item>(10);
			modifiedItems = new Vector<Item>(10);
			removedItems = new Vector<Item>(10);
			numberUploadedItems = 0;

			for (Item item : items.values()) {
				numberUploadedItems++;
				Item org_item = currentLesson.getItemByExtID(item.getExtId());
				if (org_item == null) {
					newItems.add(item);
				} else if (!item.equals(org_item, checkChapter)) {
					modifiedItems.add(item);
				}
			}

			Collections.sort(newItems, new Comparator<Item>() {
				public int compare(Item o1, Item o2) {
					if (o1.getExtId() == o2.getExtId())
						return 0;
					return o1.getExtId() < o2.getExtId() ? -1 : 1;
				}
			});

			Iterator<Item> currentItems = currentLesson.getItems().iterator();
			while (currentItems.hasNext()) {
				Item currentItem = currentItems.next();
				boolean found = false;
				for (Item item : items.values()) {
					if (currentItem.equals(item))
						found = true;
				}
				if (!found) {
					removedItems.add(currentItem);
				}
			}

			for (Item item : removedItems) {
				System.out.println(item);
			}

		} catch (Exception e) {
			session.getBrainMessage().setErrorText("Format error. Couldn't read the input file.");
			newItems = new Vector<Item>();
			numberUploadedItems = 0;
			e.printStackTrace();
			log.debug(e);
		}
	}

	private String getPattern(Vector<String> pattern, int i) {
		String ret = "AN";
		try {
			ret = pattern.get(i);
		} catch (Exception e) {
		}
		return ret;
	}

	public ListDataModel<Item> getNewItems() {
		return new ListDataModel<Item>(newItems);
	}

	public ListDataModel<Item> getModifiedItems() {
		return new ListDataModel<Item>(modifiedItems);
	}

	public ListDataModel<Item> getRemovedItems() {
		return new ListDataModel<Item>(removedItems);
	}

	public int getNumberUploadedItems() {
		return numberUploadedItems;
	}

	public int getNumberNewItems() {
		return newItems.size();
	}

	public int getNumberChangedItems() {
		return modifiedItems.size();
	}

	public int getNumberRemovedItems() {
		return removedItems.size();
	}

	public UploadedFile getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(UploadedFile uploadedFile) {
		this.uploadedFile = uploadedFile;
	}

	public void setDeleteRemovedItems(boolean v) {
		deleteRemovedItems = v;
	}

	public boolean getDeleteRemovedItems() {
		return deleteRemovedItems;
	}

	public void confirmNewItems() {
		for (Item item : newItems) {
			try {
				log.debug("store new item: " + item.getText());
				item.store();
			} catch (DBException e) {
				e.printStackTrace();
			}
		}

		for (Item item : modifiedItems) {
			try {
				log.debug("store modified item: " + item.getText());
				item.store();
			} catch (DBException e) {
				e.printStackTrace();
			}
		}

		if (deleteRemovedItems)
			for (Item item : removedItems) {
				try {
					log.debug("remove item: " + item.getText());
					item.delete();
				} catch (DBException e) {
					e.printStackTrace();
				}
			}
		deleteRemovedItems = false;
	}

}
