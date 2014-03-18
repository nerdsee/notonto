var contentBox = null;
var contentSplitter = null;

var notonto = {
	useritemid : 0,
	ntTimer : null,
	userLesson : null,
	updateInterval : 5 * 60,
	lessonNames : new Array(),
	onLoad : function() {
		// initialization code
		this.initialized = true;
		this.strings = document.getElementById("notonto-strings");
		document.getElementById("contentAreaContextMenu").addEventListener(
				"popupshowing", function(e) {
					this.showContextMenu(e);
				}, false);

		window.addEventListener("onkeydown", function(e) {
			alert('KD');
		}, false);
		window.addEventListener("oncommand", function(e) {
			alert('CO');
		}, false);

		contentBox = document.getElementById("ntContentBox");
		contentSplitter = document.getElementById("ntContentSplitter");

		this.timerCallback = {
			notify : function() {
				iNotontoAPI.requestLessons();
			}
		};

		this.ntTimer = Components.classes["@mozilla.org/timer;1"]
				.createInstance(Components.interfaces.nsITimer);
		this.ntTimer.initWithCallback(this.timerCallback,
				this.updateInterval * 1000,
				Components.interfaces.nsITimer.TYPE_REPEATING_SLACK);

		// alert("init API");
		// init API
		ntLoad();
		// alert("request Lessons");
		iNotontoAPI.requestLessons();
		iNotontoAPI.requestNextItem();
	},
	onUnload : function() {
		this.ntTimer.cancel();
	},
	showContextMenu : function(event) {
		// show or hide the menuitem based on what the context menu is on
		// see http://kb.mozillazine.org/Adding_items_to_menus
		document.getElementById("context-notonto").hidden = gContextMenu.onImage;
	},
	onMenuItemCommand : function(e) {
		var promptService = Components.classes["@mozilla.org/embedcomp/prompt-service;1"]
				.getService(Components.interfaces.nsIPromptService);
		promptService.alert(window,
				this.strings.getString("helloMessageTitle"), this.strings
						.getString("helloMessage"));
	},

	onToolbarButtonCommand : function(e) {
		notonto.onMenuItemCommand(e);
	},

	answerItem : function(answer) {
		iNotontoAPI.answerItem(answer, this.useritemid);
	},

	showOptions : function() {
		var args = {
			rc : false
		};
		var ret = openDialog('chrome://notonto/content/options.xul',
				'Preferences', 'chrome,modal,centerscreen', args);
		iNotontoAPI.requestLessons();
		iNotontoAPI.requestNextItem();
	},

	addLessons : function(userlessons) {
		// alert("addLessons");
		// var ll = document.getElementById("lesson-popup");
		var ll = document.getElementById("ntStatusContextMenu");

		var lis = document.getElementById("currentLesson");
		while (lis) {
			ll.removeChild(lis);
			lis = document.getElementById("currentLesson");
		}

		if (userlessons.length == 0) {
			mi = document.createElement("menuitem");
			attr = document.createAttribute("label");
			attr.nodeValue = "No Lessons available";
			mi.setAttributeNode(attr);
			attr = document.createAttribute("disabled");
			attr.nodeValue = "true";
			mi.setAttributeNode(attr);
			attr = document.createAttribute("id");
			attr.nodeValue = "currentLesson";
			mi.setAttributeNode(attr);
			ll.appendChild(mi);
		} else {
			var lessonID = iNotontoAPI.getIntPref("lesson");

			for (i = 0; i < userlessons.length; i++) {
				var userlesson = userlessons[i];
				this.lessonNames[userlesson.id] = userlesson.description;

				mi = document.createElement("menuitem");
				attr = document.createAttribute("label");
				attr.nodeValue = userlesson.description + "["
						+ userlesson.available + "]";
				mi.setAttributeNode(attr);
				attr = document.createAttribute("id");
				attr.nodeValue = "currentLesson";
				mi.setAttributeNode(attr);
				attr = document.createAttribute("value");
				attr.nodeValue = userlesson.id;
				mi.setAttributeNode(attr);
				attr = document.createAttribute("oncommand");
				if (typeof (userlesson.showPinyin) == 'undefined') {
					userlesson.showPinyin = true;
				}
				attr.nodeValue = "iNotontoAPI.requestLesson(" + userlesson.id
						+ ");";
				mi.setAttributeNode(attr);
				attr = document.createAttribute("type");
				attr.nodeValue = "radio";
				mi.setAttributeNode(attr);

				if ((userlesson.id == lessonID) || (lessonID == 0) && (i == 0)) {
					attr = document.createAttribute("checked");
					attr.nodeValue = "true";
					mi.setAttributeNode(attr);
					iNotontoAPI.requestLesson(userlesson.id);
				}
				if (userlesson.available < 0) {
					attr = document.createAttribute("disabled");
					attr.nodeValue = "true";
					mi.setAttributeNode(attr);
				}
				// console_a(userlesson.id+" - "+userlesson.description);
				// ll.appendItem(userlesson.description, userlesson.id, '');
				ll.appendChild(mi);
			}
		}
	},
	selectLesson : function(userlesson) {
		var st = document.getElementById("lessonnameq");
		st.value = userlesson.description; // this.lessonNames[id];
		st = document.getElementById("lessonnamea");
		st.value = userlesson.description; // this.lessonNames[id];
		st = document.getElementById("lessonnamen");
		st.value = userlesson.description; // this.lessonNames[id];

		this.userLesson = userlesson;

		iNotontoAPI.requestNextItem();
	},
	addAnswers : function(answers) {
		var gba = document.getElementById("gb_answers");
		var st = document.getElementById("ntAnswer");

		while (st) {
			gba.removeChild(st);
			st = document.getElementById("ntAnswer");
		}

		var ol = document.createElementNS("http://www.w3.org/1999/xhtml",
				"html:ul");
		var hli = null;

		attr = document.createAttribute("id");
		attr.nodeValue = "ntAnswer";
		ol.setAttributeNode(attr);

		for (i = 0; i < answers.length; i++) {
			var answer = answers[i];
			
			if (answers.length==1) {
				hli = document.createElementNS("http://www.w3.org/1999/xhtml", "html:span");
				attr = document.createAttribute("id");
				attr.nodeValue = "ntAnswer";
				hli.setAttributeNode(attr);
			} else {
				hli = document.createElementNS("http://www.w3.org/1999/xhtml", "html:li");
			}
			
			ft = document.createElementNS("http://www.w3.org/1999/xhtml", "html:font");
			attr = document.createAttribute("class");
			if (this.userLesson.lesson.alang != 'ch') {
				attr.nodeValue = "nt_answer nowrap";
			}
			if (this.userLesson.lesson.alang == 'ch') {
				attr.nodeValue = "nt_fontsym nowrap";
			}
			ft.setAttributeNode(attr);
			hli.appendChild(ft);
			tn = document.createTextNode(answer.text);
			ft.appendChild(tn);
			if (answer.phonetic != null) {
				ft = document.createElementNS("http://www.w3.org/1999/xhtml", "html:font");
				attr = document.createAttribute("class");
				attr.nodeValue = "nt_answer_pinyin";
				ft.setAttributeNode(attr);
				br = document.createElementNS("http://www.w3.org/1999/xhtml", "html:br");
				ft.appendChild(br)
				ph = document.createTextNode(answer.phonetic);
				ft.appendChild(ph);
				hli.appendChild(ft);
			}
			if (answers.length>1)
				ol.appendChild(hli);
		}
		if (answers.length==1)
			gba.appendChild(hli);
		else
			gba.appendChild(ol);

	},
	noItem : function() {
		this.showNone();
	},
	displayItem : function(useritem) {

		var st = document.getElementById("ntQuestion");

		// st.value=useritem.item.text;

	var fc = "nt_font1";
	if (this.userLesson.type == 1) {
		fc = "nt_fontsym";
	} else {
		fc = "nt_font1";
	}

	// neuer code f�r html fragetext
	var text = "<?xml version=\"1.0\" ?>";
	text += "<description flex=\"2\" xmlns:html=\"http://www.w3.org/1999/xhtml\" id=\"ntQuestion\" class=\"nt_font1\"><html:nobr><html:font class=\""
			+ fc + "\">";
	text += useritem.item.text;
	text += "</html:font></html:nobr></description>";

	var parser = new DOMParser();
	var doc = parser.parseFromString(text, "text/xml");

	if (doc.getElementsByTagName("parsererror").length) {
		st.value = useritem.item.text;
	} else {
		st.parentNode.replaceChild(doc.documentElement, st);
		st = document.getElementById("ntQuestion");
	}

	this.useritemid = useritem.id;

	this.addAnswers(useritem.item.answers);

	var st = document.getElementById("ntComment");
	var st2 = document.getElementById("ntComment2");
	if ((this.userLesson.type == 1) && (this.userLesson.showPinyin)) {
		st.value = useritem.item.comment;
		st2.value = "";
		st2.setAttribute("class", "nt_hidden");
	} else {
		if (useritem.item.comment.length > 0) {
			st2.value = useritem.item.comment;
			st2.setAttribute("class", "nt_pinyin");
		} else {
			st2.value = "";
			st2.setAttribute("class", "nt_hidden");
		}
		st.value = "";
		// st.value="I: " + this.type + " - " + this.showPinyin;
	}

	var lv = document.getElementById("ntLevel");
	lv.value = "Level " + (useritem.level + 1);
	var lv2 = document.getElementById("ntLevel2");
	lv2.value = lv.value;

	this.showQuestion();

	// Timer reset
	this.ntTimer.cancel();
	this.ntTimer = Components.classes["@mozilla.org/timer;1"]
			.createInstance(Components.interfaces.nsITimer);
	this.ntTimer.initWithCallback(this.timerCallback,
			this.updateInterval * 1000,
			Components.interfaces.nsITimer.TYPE_REPEATING_SLACK);

},
displayCounter : function(current, total) {
	var st = document.getElementById("notontoStatusText");
	st.value = "Notonto [" + current + "/" + total + "]";
},
displayLesson : function(title) {
	// alert("I: " + useritem.item.text);
	var st = document.getElementById("notontoStatusText");
	st.value = title;
},
refresh : function() {
	iNotontoAPI.requestLessons();
},
toggleDisplay : function(event) {
	if (event.button != 2) {
		contentBox.collapsed = !contentBox.collapsed;
		contentSplitter.collapsed = !contentSplitter.collapsed;
	}
},
showAnswer : function(event) {
	var aq = document.getElementById("area_question");
	var aa = document.getElementById("area_answer");
	var an = document.getElementById("area_none");
	var nc = document.getElementById("area_no_connection");

	aq.hidden = true;
	aa.hidden = false;
	an.hidden = true;
	nc.hidden = true;

	var ic = document.getElementById("notontoIcon");
	ic.setAttribute("class", "notontoIcon");
},
showQuestion : function(event) {
	var aq = document.getElementById("area_question");
	var aa = document.getElementById("area_answer");
	var an = document.getElementById("area_none");
	var nc = document.getElementById("area_no_connection");

	aa.hidden = true;
	aq.hidden = false;
	an.hidden = true;
	nc.hidden = true;

	var ic = document.getElementById("notontoIcon");
	ic.setAttribute("class", "notontoIcon");
},
showNone : function(event) {
	var aq = document.getElementById("area_question");
	var aa = document.getElementById("area_answer");
	var an = document.getElementById("area_none");
	var nc = document.getElementById("area_no_connection");

	aa.hidden = true;
	aq.hidden = true;
	an.hidden = false;
	nc.hidden = true;

	var ic = document.getElementById("notontoIcon");
	ic.setAttribute("class", "notontoIcon");
},
showNoConn : function(event) {
	var aq = document.getElementById("area_question");
	var aa = document.getElementById("area_answer");
	var an = document.getElementById("area_none");
	var nc = document.getElementById("area_no_connection");

	aa.hidden = true;
	aq.hidden = true;
	an.hidden = true;
	nc.hidden = false;

	var ic = document.getElementById("notontoIcon");
	ic.setAttribute("class", "notontoIconAlert");
},
nextQuestion : function(event) {
	iNotontoAPI.requestNextItem();
}

};
window.addEventListener("load", function(e) {
	notonto.onLoad(e);
}, false);
window.addEventListener("unload", function(e) {
	notonto.onUnload(e);
}, false);
