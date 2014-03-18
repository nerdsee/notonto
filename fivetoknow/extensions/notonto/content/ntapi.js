var iNotontoAPI = null;
var proxy = null;

function NotontoAPI () {
	return this;
}

function ntLoad() {
	iNotontoAPI = new NotontoAPI();
}

function ntUnload() {
	iNotontoAPI = null;
}

NotontoAPI.prototype =
{
	//apiURL: "http://www.notonto.com/fivetoknow/api/json/",
	currentItem: null,
	iprefs: null,
    requestLessons: function() {
		//alert("API: requestLessons");
		var request = new XMLHttpRequest();
		request.onreadystatechange = function() {

			if (request.readyState == 4) {
				try {
				
					if (request.status == 200) {
						var jsonObject = eval('(' + request.responseText + ')');
				    	notonto.addLessons(jsonObject.userlessons);
					}
				} catch (e) {
					//alert("EXC RL: " + e);
					notonto.showNoConn();
				}	
			}
		}

		var user=this.getCharPref("username");
		var pass=this.getCharPref("password");
		var apiURL=this.getServerPref();
		
		request.open("GET", apiURL + user + "/" + pass + "/lessons");
		request.send(' ');
	},
    requestLesson: function(ulid) {
		//alert("API: requestLesson " + ulid);
		var request = new XMLHttpRequest();
		request.onreadystatechange = function() {

			if (request.readyState == 4) {
				try {
				
					if (request.status == 200) {
						var jsonObject = eval('(' + request.responseText + ')');
						//alert(request.responseText);
						notonto.selectLesson(jsonObject.userlesson);
					}
				} catch (e) {
					//alert("EXC RL: " + e);
					notonto.showNoConn();
				}	
			}
		}

		var user=this.getCharPref("username");
		var pass=this.getCharPref("password");
		var apiURL=this.getServerPref();
		
		request.open("GET", apiURL + user + "/" + pass + "/lesson/"+ulid);
		request.send(' ');
		
		this.setIntPref("lesson",ulid);

	},
	/**
	*	liest das n�chste Element
	*/
	requestNextItem: function() {
	//alert("next item");
		var request = new XMLHttpRequest();
		request.onreadystatechange = function() {

			if (request.readyState == 4) {
				try {
				
					if (request.status == 200) {
						//console_a("resp:");
						//alert(request.responseText);
						var jsonObject = eval('(' + request.responseText + ')');
						//alert(request.responseText);
						//var result=request.responseText;
						
						if ( jsonObject.msg==1 ) {
							notonto.noItem();
						} else {
							notonto.displayItem(jsonObject.useritem);
						}
						notonto.displayCounter(jsonObject.opencurrent,jsonObject.opentotal);
					}
				} catch (e) {
					//alert("EXC RNI: " + e.stack);
					notonto.showNoConn();
				}	
			}
		}
		
		var user=this.getCharPref("username");
		var pass=this.getCharPref("password");
		var apiURL=this.getServerPref();

		var ulid = this.getIntPref("lesson");
		
		request.open("GET", apiURL + user + "/" + pass + "/nextitem/" + ulid);
		request.send(' ');
		//console_a("\nRequest sent.");
	},
    NextItemCallback: function (answer) {
		notonto.displayItem(answer.useritem);
	},

	/**
	*	angabe der Antwort gewusst ja/nein
	*/
	answerItem: function(answer, useritemid) {
	//alert("remember item");
		var request = new XMLHttpRequest();
		request.onreadystatechange = function() {

			if (request.readyState == 4) {
				try {
				
					if (request.status == 200) {
						//alert(request.responseText);
						var jsonObject = eval('(' + request.responseText + ')');
						//if (jsonObject.error) {
						//	alert("ERROR: " + jsonObject.error);
						//}
					  	iNotontoAPI.requestNextItem(); 
					}
				} catch (e) {
					//alert("EXC AI: " + e);
					notonto.showNoConn();
				}	
			}
		}
		
		var user=this.getCharPref("username");
		var pass=this.getCharPref("password");
		var apiURL=this.getServerPref();

		var ulid = this.getIntPref("lesson");
		
		request.open("GET", apiURL + user + "/" + pass + "/answeritem/"+ (answer?"t/":"f/") + useritemid);
		request.send(' ');
		//console_a("\nRequest sent.");
	},
	getPrefs: function() {
		if (this.iprefs == null) {
			this.iprefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService);
			this.iprefs = this.iprefs.getBranch("extensions.notonto.");
		}
		return this.iprefs; 
	},
	getCharPref: function(name) {
		var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService);
		prefs = prefs.getBranch("extensions.notonto.");
		return this.getPrefs().getCharPref(name);
	},
	setCharPref: function(name, value) {
		var prefs = Components.classes["@mozilla.org/preferences-service;1"].getService(Components.interfaces.nsIPrefService);
		prefs = prefs.getBranch("extensions.notonto.");
		this.getPrefs().setCharPref(name, value);
	},
	getIntPref: function(name) {
		return this.getPrefs().getIntPref(name);
	},
	setIntPref: function(name, value) {
		this.getPrefs().setIntPref(name, value);
	},
	getServerPref: function() {
		var apiURL=this.getCharPref("server");
		if (apiURL=="###") {
		 apiURL="http://localhost:8090/rest/10/";
		} else {
		 apiURL="http://www.notonto.de/rest/10/";
		}
		return apiURL;
	}
}

