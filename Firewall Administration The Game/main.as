package 
{
	import fl.containers.ScrollPane;
	import fl.controls.TextArea;
	import fl.events.InteractionInputType;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Scott Thompson
	 */
	public class main extends MovieClip
	{
		
		public var mcSettingsBtn:MovieClip;
		public var background:MovieClip;
		
		/*start screen objs*/
		public var mcStartBtn:MovieClip;
		
		/*settings screen objs*/
		public var settingsBackground:MovieClip;
		public var mcHardBtn:MovieClip;
		public var mcEasyBtn:MovieClip;
		public var mcMediumBtn:MovieClip;
		
		/*terminal screen decs*/
		public var boxes:MovieClip;
		public var mcBreifingBtn:MovieClip;
		public var mcLevelSelectBtn:MovieClip;
		public var mcFirewallText:TextArea;
		public var mcFinishBtn:MovieClip;
		public var mcTerminalPane:MovieClip;
		public var origPane:MovieClip;
		public var scrollPane:ScrollPane = null;
		public var tbar:MovieClip;
		public var tblack:MovieClip;
		
		/*Level select objs*/
		public var levelBtn1:MovieClip;
		public var levelBtn2:MovieClip;
		public var levelBtn3:MovieClip;
		public var levelBtn4:MovieClip;
		public var levelBtn5:MovieClip;
		public var levelBtn6:MovieClip;
		public var levelBtn7:MovieClip;
		public var levelBtn8:MovieClip;
		public var levelBtn9:MovieClip;
		public var levelBtn10:MovieClip;
		public var levelBtn11:MovieClip;
		public var levelBtn12:MovieClip;
		public var levelBtn13:MovieClip;
		public var levelBtn14:MovieClip;
		public var levelBtn15:MovieClip;
		public var levelBtn16:MovieClip;
		public var levelBtn17:MovieClip;
		public var levelBtn18:MovieClip;
		public var levelBtn19:MovieClip;
		public var levelBtn20:MovieClip;
		public var levelBtn21:MovieClip;
		public var levelBtn22:MovieClip;
		public var levelBtn23:MovieClip;
		public var levelBtn24:MovieClip;
		public var levelBtn25:MovieClip;
		public var levelButtons: Array;
		public var mcHomeBtn:MovieClip;
		public var background1:MovieClip;	
		public var background2:MovieClip;	
		public var background3:MovieClip;	
		
		/*breif objs*/
		public var backgroundbreif1:MovieClip;	
		public var backgroundbreif2:MovieClip;	
		public var backgroundbreif3:MovieClip;
		public var mcLevelSelectBtnB:MovieClip;
		public var mcContinueBtnB:MovieClip;
		public var mcBreifText:TextArea;
		
		/* feedback screen objs*/
		public var failureEmailText:MovieClip;
		public var failureScreen:MovieClip;
		public var successEmailText:MovieClip;
		public var successScreen:MovieClip;
		public var mcLevelSelectBtnF:MovieClip;
		public var mcRestartBtnF:MovieClip;
		public var mcContinueBtnF:MovieClip;
		public var mcNextLevelBtnF:MovieClip;
		public var mcFeedbackText:TextArea;
		public var fbbackground1:MovieClip;
		
		
		private var newLine = new TextField();
		private var currentTerminalY = 5;
		private var chains:Dictionary = new Dictionary();
		private var chainPolicy:Dictionary = new Dictionary();
		
		private var currLevel:int = 0;
		private var currDifficulty:int = 0;
		private var answers:Array = new Array();
		private var levels:Array = new Array();
		
		private var currScreen = "START";
		private var lastScreen = "LVLSELECT";
		
		var fail:Boolean = false;
		
		public function main() {
			
			mcTerminalPane.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { if (newLine) {stage.focus = newLine } });
			
			boxes.visible = false;
			mcBreifingBtn.visible = false;
			mcBreifingBtn.mouseEnabled = false;
			mcLevelSelectBtn.visible = false
			mcLevelSelectBtn.mouseEnabled = false;
			mcFirewallText.visible = false
			mcFirewallText.mouseEnabled = false;
			mcFinishBtn.visible = false
			mcFinishBtn.mouseEnabled = false;
			mcTerminalPane.visible = false
			mcTerminalPane.mouseEnabled = false;
			tbar.visible = false;
			tblack.visible = false;
			
			mcHardBtn.visible = false
			mcHardBtn.mouseEnabled = false;
			mcHardBtn.buttonMode = true;
			mcHardBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { currDifficulty = 2; updateBreif(); if (lastScreen == "START" || lastScreen == "SETTINGS") { showScreen("LVLSELECT") } else {showScreen(lastScreen) }});
			
			mcEasyBtn.visible = false
			mcEasyBtn.mouseEnabled = false;
			mcEasyBtn.buttonMode = true;
			mcEasyBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { currDifficulty = 0; updateBreif(); if (lastScreen == "START" || lastScreen == "SETTINGS") { showScreen("LVLSELECT") } else {showScreen(lastScreen) }});
			
			mcMediumBtn.visible = false
			mcMediumBtn.mouseEnabled = false;
			mcMediumBtn.buttonMode = true;
			mcMediumBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { currDifficulty = 1; updateBreif(); if (lastScreen == "START" || lastScreen == "SETTINGS") { showScreen("LVLSELECT") } else {showScreen(lastScreen) }});
			
			settingsBackground.visible = false;
			
			mcStartBtn.buttonMode = true;
			mcStartBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("SETTINGS") });
			
			levelButtons = new Array(levelBtn1, levelBtn2, levelBtn3, levelBtn4, levelBtn5,levelBtn6,levelBtn7,levelBtn8,levelBtn9,levelBtn10,levelBtn11,levelBtn12,levelBtn13,levelBtn14,levelBtn15,levelBtn16,levelBtn17,levelBtn18,levelBtn19,levelBtn20,levelBtn21,levelBtn22,levelBtn23,levelBtn24,levelBtn25);
			var aa = 0;
			for (var x:String in levelButtons) {
				levelButtons[x].visible = false;
				levelButtons[x].mouseEnabled = false;
				levelButtons[x].buttonMode = true;
				levelButtons[x].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void {currLevel = levelButtons.indexOf(e.currentTarget as MovieClip); updateBreif(); setupChains(levels[currLevel]); hardResetTerminal(); showScreen("BREIF")});
				aa++;
			}
			
			mcHomeBtn.buttonMode = true;
			mcHomeBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("START") });
			mcHomeBtn.visible = false;
			mcHomeBtn.mouseEnabled = false;
			
			background1.visible = false;
			background1.mouseEnabled = false;
			background2.visible = false;
			background2.mouseEnabled = false;
			background3.visible = false;
			background3.mouseEnabled = false;
			
			mcSettingsBtn.buttonMode = true;
			mcSettingsBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("SETTINGS") });

			backgroundbreif1.visible = false;
			backgroundbreif1.mouseEnabled = false;
			backgroundbreif2.visible = false;
			backgroundbreif2.mouseEnabled = false;
			backgroundbreif3.visible = false;
			backgroundbreif3.mouseEnabled = false;
			
			mcLevelSelectBtnB.buttonMode = true;
			mcLevelSelectBtnB.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("LVLSELECT") });
			mcLevelSelectBtnB.mouseEnabled = false;
			mcLevelSelectBtnB.visible = false;
			
			mcContinueBtnB.buttonMode = true;
			mcContinueBtnB.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("TERM") });
			mcContinueBtnB.mouseEnabled = false;
			mcContinueBtnB.visible = false;
			
			mcBreifText.visible = false;
			mcBreifText.editable = false;
			mcBreifText.enabled = true;
			mcBreifText.mouseChildren = false;
			
			mcContinueBtnF.buttonMode = true;
			mcContinueBtnF.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("TERM") });
			mcContinueBtnF.mouseEnabled = false;
			mcContinueBtnF.visible = false;
			
			mcLevelSelectBtnF.buttonMode = true;
			mcLevelSelectBtnF.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("LVLSELECT") });
			mcLevelSelectBtnF.mouseEnabled = false;
			mcLevelSelectBtnF.visible = false;
			
			mcRestartBtnF.buttonMode = true;
			mcRestartBtnF.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { setupChains(levels[currLevel]); hardResetTerminal();  showScreen("TERM") });
			mcRestartBtnF.mouseEnabled = false;
			mcRestartBtnF.visible = false;
			
			mcNextLevelBtnF.buttonMode = true;
			mcNextLevelBtnF.addEventListener(MouseEvent.CLICK, nextLevel);
			mcNextLevelBtnF.mouseEnabled = false;
			mcNextLevelBtnF.visible = false;
			
			mcFeedbackText.mouseEnabled = false;
			mcFeedbackText.visible = false;
			mcFeedbackText.editable = false;
			failureEmailText.mouseEnabled = false;
			failureEmailText.visible = false;
			failureScreen.mouseEnabled = false;
			failureScreen.visible = false;
			successEmailText.mouseEnabled = false;
			successEmailText.visible = false;
			successScreen.mouseEnabled = false;
			successScreen.visible = false;
			fbbackground1.mouseEnabled = false;
			fbbackground1.visible = false;
			
			mcFinishBtn.buttonMode = true;
			mcFinishBtn.addEventListener(MouseEvent.CLICK, finishLevel);
			
			mcBreifingBtn.buttonMode = true;
			mcBreifingBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { updateBreif();showScreen("BREIF") });

			mcLevelSelectBtn.buttonMode = true;
			mcLevelSelectBtn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) : void { showScreen("LVLSELECT") });

			mcFirewallText.editable = false;

			setupLevels();
			terminalSetup();
		}
		
		private function showScreen(screen2show:String):void {
			
			if (currScreen == "START") {
				mcStartBtn.visible = false;
				mcStartBtn.mouseEnabled = false;
			} else if (currScreen == "TERM") {
				boxes.visible = false;
				mcBreifingBtn.visible = false;
				mcBreifingBtn.mouseEnabled = false;
				mcLevelSelectBtn.visible = false
				mcLevelSelectBtn.mouseEnabled = false;
				mcFirewallText.visible = false
				mcFirewallText.mouseEnabled = false;
				mcFinishBtn.visible = false
				mcFinishBtn.mouseEnabled = false;
				mcTerminalPane.visible = false
				mcTerminalPane.mouseEnabled = false;
				tbar.visible = false;
				tblack.visible = false;
				if (scrollPane) {
					scrollPane.visible = false;
					scrollPane.mouseEnabled = false;
				}
				
			} else if (currScreen == "SETTINGS") {
				mcHardBtn.visible = false
				mcHardBtn.mouseEnabled = false;
				mcEasyBtn.visible = false
				mcEasyBtn.mouseEnabled = false;
				mcMediumBtn.visible = false
				mcMediumBtn.mouseEnabled = false;
				settingsBackground.visible = false;
				
			} else if (currScreen == "LVLSELECT") {
				for (var x:String in levelButtons) {
					levelButtons[x].visible = false;
					levelButtons[x].mouseEnabled = false;
				}
				mcHomeBtn.visible = false;
				mcHomeBtn.mouseEnabled = false;
				background1.visible = false;
				background1.mouseEnabled = false;
				background2.visible = false;
				background2.mouseEnabled = false;
				background3.visible = false;
				background3.mouseEnabled = false;
			
			} else if (currScreen == "BREIF") {
				backgroundbreif1.visible = false;
				backgroundbreif1.mouseEnabled = false;
				backgroundbreif2.visible = false;
				backgroundbreif2.mouseEnabled = false;
				backgroundbreif3.visible = false;
				backgroundbreif3.mouseEnabled = false;
				mcLevelSelectBtnB.mouseEnabled = false;
				mcLevelSelectBtnB.visible = false;
				mcContinueBtnB.mouseEnabled = false;
				mcContinueBtnB.visible = false;
				mcBreifText.visible = false;
			} else if (currScreen == "FEED") {
				mcContinueBtnF.mouseEnabled = false;
				mcContinueBtnF.visible = false;
				mcLevelSelectBtnF.mouseEnabled = false;
				mcLevelSelectBtnF.visible = false;
				mcRestartBtnF.mouseEnabled = false;
				mcRestartBtnF.visible = false;
				mcNextLevelBtnF.mouseEnabled = false;
				mcNextLevelBtnF.visible = false;
				mcFeedbackText.mouseEnabled = false;
				mcFeedbackText.visible = false;
				mcFeedbackText.editable = false;
				failureEmailText.mouseEnabled = false;
				failureEmailText.visible = false;
				failureScreen.mouseEnabled = false;
				failureScreen.visible = false;
				successEmailText.mouseEnabled = false;
				successEmailText.visible = false;
				successScreen.mouseEnabled = false;
				successScreen.visible = false;
				fbbackground1.mouseEnabled = false;
				fbbackground1.visible = false;
				
			}
			lastScreen = currScreen;
			if (screen2show == "START") {
				mcStartBtn.visible = true;
				mcStartBtn.mouseEnabled = true;
				currScreen = "START"
			} else if (screen2show == "TERM") {
				boxes.visible = true;
				mcBreifingBtn.visible = true;
				mcBreifingBtn.mouseEnabled = true;
				mcLevelSelectBtn.visible = true
				mcLevelSelectBtn.mouseEnabled = true;
				mcFirewallText.visible = true
				mcFirewallText.mouseEnabled = true;
				mcFinishBtn.visible = true
				mcFinishBtn.mouseEnabled = true;
				mcTerminalPane.visible = true
				mcTerminalPane.mouseEnabled = true;
				tbar.visible = true;
				tblack.visible = true;
				if (scrollPane) {
					scrollPane.visible = true;
					scrollPane.mouseEnabled = true;
				}
				stage.focus = newLine
				currScreen = "TERM"
			} else if (screen2show == "SETTINGS") {
				mcHardBtn.visible = true
				mcHardBtn.mouseEnabled = true;
				mcEasyBtn.visible = true
				mcEasyBtn.mouseEnabled = true;
				mcMediumBtn.visible = true
				mcMediumBtn.mouseEnabled = true;
				settingsBackground.visible = true;
				currScreen = "SETTINGS"
			} else if (screen2show == "LVLSELECT") {
				for (var x:String in levelButtons) {
					levelButtons[x].visible = true;
					levelButtons[x].mouseEnabled = true;
				}
				mcHomeBtn.visible = true;
				mcHomeBtn.mouseEnabled = true;
				background1.visible = true;
				background1.mouseEnabled = true;
				background2.visible = true;
				background2.mouseEnabled = true;
				background3.visible = true;
				background3.mouseEnabled = true;
				currScreen = "LVLSELECT"
			} else if (screen2show == "BREIF") {
				backgroundbreif1.visible = true;
				backgroundbreif2.visible = true;
				backgroundbreif3.visible = true;
				mcLevelSelectBtnB.mouseEnabled = true;
				mcLevelSelectBtnB.visible = true;
				mcContinueBtnB.mouseEnabled = true;
				mcContinueBtnB.visible = true;
				mcBreifText.visible = true;
				currScreen = "BREIF"
			} else if (screen2show == "FEED") {
				mcContinueBtnF.mouseEnabled = true;
				mcContinueBtnF.visible = true;
				mcLevelSelectBtnF.mouseEnabled = true;
				mcLevelSelectBtnF.visible = true;
				mcRestartBtnF.mouseEnabled = true;
				mcRestartBtnF.visible = true;
				mcNextLevelBtnF.mouseEnabled = true;
				mcNextLevelBtnF.visible = true;
				mcFeedbackText.mouseEnabled = true;
				mcFeedbackText.visible = true;
				mcFeedbackText.editable = true;
				fbbackground1.mouseEnabled = true;
				fbbackground1.visible = true;
				currScreen = "FEED"
				if (fail) {
					failureEmailText.mouseEnabled = true;
					failureEmailText.visible = true;
					failureScreen.mouseEnabled = true;
					failureScreen.visible = true;
				} else {
					successEmailText.mouseEnabled = true;
					successEmailText.visible = true;
					successScreen.mouseEnabled = true;
					successScreen.visible = true;
				}
			}
		}
		
		public function terminalSetup():void 
		{
			mcTerminalPane.opaqueBackground = 0x000000;
			newTerminalLine();
			scrollPane.visible = false;
			scrollPane.mouseEnabled = false;
		}
		
		
		
		private function updateBreif():void 
		{
			var brief:String = "";

			if (currDifficulty == 0) {
				brief = levels[currLevel].briefing_easy;
			} else if (currDifficulty == 1) {
				brief = levels[currLevel].briefing_medium;
			} else {
				brief = levels[currLevel].briefing_hard;
			}
			
			mcBreifText.htmlText = brief;
		}
		
		private function setupChains(level:Object):void {
			if (level.chains && level.chainsPolicy) {
				chains = new Dictionary();
				chains["ALL"] = new Array();
				for (var chain:String in level.chains) {
					chains[chain] = new Array();
					if (chain != "ALL") {
						for (var rule:String in level.chains[chain]) {
							chains[chain].push(level.chains[chain][rule].clone())
						}
					}
				}
				chainPolicy = clone(level.chainsPolicy)
			} else {
				chains = new Dictionary();
				chainPolicy = new Dictionary();
				chains["INPUT"] = new Array();
				chainPolicy["INPUT"] = "ACCEPT";
				chains["FORWARD"] = new Array();
				chainPolicy["FORWARD"] = "ACCEPT";
				chains["OUTPUT"] = new Array();
				chainPolicy["OUTPUT"] = "ACCEPT";
				chains["ALL"] = new Array();
			}
		}
		
		private function nextLevel(e:Event):void 
		{
			if (levels[currLevel + 1]) {
				currLevel++;
				setupChains(levels[currLevel]);
				updateBreif();
				hardResetTerminal();
				showScreen("BREIF");
			} else {
				showScreen("LVLSELECT");
			}
		}
		
		
		
		private function newTerminalLine():void 
		{
			if (currentTerminalY > 315) {
				mcTerminalPane.height = mcTerminalPane.height + 20;
				mcTerminalPane.scaleX = 1.0
				mcTerminalPane.scaleY = 1.0
				
				var termPreSym = new TextField();
				mcTerminalPane.addChild(termPreSym);
				termPreSym.width = 20;
				termPreSym.height = 20;
				termPreSym.x = 5;
				termPreSym.y = currentTerminalY;
				termPreSym.border = false
				termPreSym.type = TextFieldType.DYNAMIC;
				termPreSym.text = ">";
				termPreSym.textColor = 0xFFFFFF;

				newLine = new TextField();
				mcTerminalPane.addChild(newLine);
				newLine.width = 450;
				newLine.height = 20;
				newLine.x = 25;
				newLine.y = currentTerminalY;
				newLine.border = false
				newLine.type = TextFieldType.INPUT;
				newLine.textColor = 0xFFFFFF;
				newLine.addEventListener(KeyboardEvent.KEY_UP, terminalKeyHandler);

				currentTerminalY = currentTerminalY + 20;
				if (scrollPane) {
					removeChild(scrollPane);
				}
				scrollPane = new ScrollPane();
				scrollPane.x = 25.85;
				scrollPane.y = 263.6;
				scrollPane.width = 503;
				scrollPane.height = 315;
				scrollPane.visible = true;
				scrollPane.source = mcTerminalPane;
				addChildAt(scrollPane, 7);
				scrollPane.verticalScrollPosition = int.MAX_VALUE;
				stage.focus = newLine;
			} else {
				if (scrollPane) {
					removeChild(scrollPane);
				}
				scrollPane = new ScrollPane();
				scrollPane.x = 25.85;
				scrollPane.y = 263.6;
				scrollPane.width = 503;
				scrollPane.height = 315;
				scrollPane.visible = true;
				scrollPane.source = mcTerminalPane;
				addChildAt(scrollPane,7);
				newLine.setSelection(newLine.text.length, newLine.text.length);
				
				var termPreSym = new TextField();
				mcTerminalPane.addChild(termPreSym);
				termPreSym.width = 20;
				termPreSym.height = 20;
				termPreSym.x = 5;
				termPreSym.y = currentTerminalY;
				termPreSym.border = false
				termPreSym.type = TextFieldType.DYNAMIC;
				termPreSym.text = ">";
				termPreSym.textColor = 0xFFFFFF;

				newLine = new TextField();
				mcTerminalPane.addChild(newLine);
				newLine.width = 450;
				newLine.height = 20;
				newLine.x = 25;
				newLine.y = currentTerminalY;
				newLine.border = false
				newLine.type = TextFieldType.INPUT;
				newLine.textColor = 0xFFFFFF;
				newLine.addEventListener(KeyboardEvent.KEY_UP, terminalKeyHandler);

				currentTerminalY = currentTerminalY + 20;
				stage.focus = newLine;
			}
		}
		
		private function terminalKeyHandler(e:KeyboardEvent):void 
		{
			if (e.keyCode == 13) {
				newLine.type = TextFieldType.DYNAMIC;
				newTerminalResponse(newLine.text);

				if (scrollPane) {
					scrollPane.verticalScrollPosition = int.MAX_VALUE;
				}
				newTerminalLine();
			}
		}
		
		public function hardResetTerminal():void 
		{
			updateFWText();
			while (mcTerminalPane.numChildren > 3) {
				mcTerminalPane.removeChildAt(3)
			}
			if (scrollPane) {
				//removeChild(scrollPane);
			}
			currentTerminalY = 5;
			terminalSetup();
		}
		
		
		private function newTerminalResponse(object:Object):void 
		{
				var response:String = "";
			
				var pattern:RegExp = /(\S+)/g;
				var input:String = object as String
				var regResult:Array = [];
				var result:Object = null;
				while (result = pattern.exec(input)) {
					regResult.push(result[0]);
				}
				
				var sudo:Boolean = false;
				var iptables:Boolean = false;
				var help = false;
				
				var badArg:String = "";
				
				//Commands
				var L:String = "";
				var A:String = "";
				
				var I:String = "";
				var Inum:int = 1;
				var D:String = "";
				var Dnum:int = 1;
				var R:String = "";
				var Rnum:int = -1;
				var Eold:String = "";
				var Enew:String = "";
				var Pchain:String = "";
				var Pol:String = "";
				var F:String = "";
				var NC:String = "";
				
				//Options
				
				var m:String = "";
				var p:String = "";
				var dport:String = "";
				var sport:String = "";
				var j:String = "";	
				var i:String = "";
				var v:Boolean = false;
				var s:String = "";	
				var d:String = "";
				var o:String = "";
				var ctstate:String = "";
				
				for (var x = 0; x < regResult.length; x = x + 1) {
					if (x == 0 && regResult[0] == "sudo" && regResult[1] == "iptables") {
						sudo = true;
						iptables = true;
						x++;
					} else if (x == 0 && regResult[x] == "iptables") {
						iptables = true;
					} else if (regResult[x] == "-L" || regResult[x] == "--list") {
						if (regResult[x + 1]) {
							L = regResult[x + 1];
							x++;
						} else {
							L = "ALL";
						}
					} else if (regResult[x] == "-h" || regResult[x] == "--help") {
						help = true;
					} else if (regResult[x] == "-A" || regResult[x] == "--append") {
						if (regResult[x + 1]) {
							A = regResult[x + 1];
							x++; 
						} else {
							A = "NONE";
						}
					} else if (regResult[x] == "-m" || regResult[x] == "--match") {
						if (regResult[x + 1]) {
							m = regResult[x + 1];
							x++; 
						} else {
							m = "NONE";
						}
					} else if (regResult[x] == "--ctstate") {
						if (regResult[x + 1]) {
							ctstate = regResult[x + 1];
							x++; 
						} else {
							ctstate = "NONE";
						}
					} else if (regResult[x] == "-p" || regResult[x] == "--proto") {
						if (regResult[x + 1]) {
							p = regResult[x + 1];
							x++; 
						} else {
							p = "NONE";
						}
					} else if (regResult[x] == "--dport") {
						if (regResult[x + 1]) {
							dport = regResult[x + 1];
							x++; 
						} else {
							dport = "NONE";
						}
					} else if (regResult[x] == "--sport") {
						if (regResult[x + 1]) {
							sport = regResult[x + 1];
							x++; 
						} else {
							sport = "NONE";
						}
					} else if (regResult[x] == "-j" || regResult[x] == "--jump") {
						if (regResult[x + 1]) {
							j = regResult[x + 1];
							x++; 
						} else {
							j = "NONE";
						}
					} else if (regResult[x] == "-i" || regResult[x] == "--in-interface") {
						if (regResult[x + 1]) {
							i = regResult[x + 1];
							x++; 
						} else {
							i = "NONE";
						}
					} else if (regResult[x] == "-I" || regResult[x] == "--insert") {
						if (regResult[x + 1] && regResult[x+2] && !(isNaN(Number(regResult[x+2])))) {
							I = regResult[x + 1];
							Inum = Number(regResult[x +2]);
							x = x + 2; 
						} else if (regResult[x + 1]) {
							I = regResult[x + 1];
							x = x + 1;
						} else {
							I = "NONE";
						}
					} else if (regResult[x] == "-D" || regResult[x] == "--delete") {
						if (regResult[x + 1] && regResult[x+2] && !(isNaN(Number(regResult[x+2])))) {
							D = regResult[x + 1];
							Dnum = Number(regResult[x +2]);
							x = x + 2; 
						} else if (regResult[x + 1]) {
							D = regResult[x + 1];
							x = x + 1;
						} else {
							D = "NONE";
						}
					} else if (regResult[x] == "-R" || regResult[x] == "--replace") {
						if (regResult[x + 1] && regResult[x+2] && !(isNaN(Number(regResult[x+2])))) {
							R = regResult[x + 1];
							Rnum = Number(regResult[x +2]);
							x = x + 2; 
						} else if (regResult[x + 1]) {
							R = regResult[x + 1];
							Rnum = 1
							x = x + 1;
						} else {
							R = "NONE";
						}
					} else if (regResult[x] == "-v" || regResult[x] == "--verbose") {
						v = true;
					} else if (regResult[x] == "-s" || regResult[x] == "--source") {
						if (regResult[x + 1]) {
							s = regResult[x + 1];
							x++; 
						} else {
							s = "NONE";
						}
					} else if (regResult[x] == "-d" || regResult[x] == "--destination") {
						if (regResult[x + 1]) {
							d = regResult[x + 1];
							x++; 
						} else {
							d = "NONE";
						}
					} else if (regResult[x] == "-o" || regResult[x] == "--out-interface") {
						if (regResult[x + 1]) {
							o = regResult[x + 1];
							x++; 
						} else {
							o = "NONE";
						}
					} else if (regResult[x] == "-F" || regResult[x] == "--flush") {
						if (regResult[x + 1]) {
							F = regResult[x + 1];
							x++; 
						} else {
							F = "ALL";
						}
					} else if (regResult[x] == "-P" || regResult[x] == "--policy") {
						if (regResult[x + 1] && regResult[x + 2] && chains[regResult[x+1]] != null && (regResult[x+2] == "DROP" || regResult[x+2] == "ACCEPT" || regResult[x+2] == "REJECT")) {
							Pchain = regResult[x + 1] 
							Pol = regResult[x + 2];
							x = x + 2;
						} else if (regResult[x + 1] && regResult[x + 2] && chains[regResult[x+1]] != null) {
							Pchain = "BAD";
						} else if (!(regResult[x + 1] && regResult[x + 2])) {
							Pchain = "REQUIRES";
							if (regResult[x + 1]) {
								x = x +1;
							}
						} else {
							Pchain = "NONE";
							x = x + 2;
						}
					} else if (regResult[x] == "--rename-chain" || regResult[x] == "-E") {
						if (regResult[x + 1] && regResult[x + 2] && chains[regResult[x+1]] != null && (regResult[x+1] != "INPUT" || regResult[x+1] != "FORWARD" || regResult[x+1] != "OUTPUT")) {
							Eold = regResult[x + 1];
							Enew = regResult[x + 2];
							x = x + 2;
						} else if (regResult[x + 1] && regResult[x + 2] && (regResult[x+1] == "INPUT" || regResult[x+1] == "FORWARD" || regResult[x+1] == "OUTPUT")) {
							Eold = "PROHIBITED";
							x = x + 2;
						} else if (!(regResult[x + 1] && regResult[x + 2])) {
							Eold = "REQUIRES";
							if (regResult[x + 1]) {
								x = x +1;
							}
						} else {
							Eold = "NONE";
							x = x +2;
						}
					} else if (regResult[x] == "-N" || regResult[x] == "-new") {
						if (regResult[x + 1]) {
							NC = regResult[x + 1];
							x++; 
						} else {
							NC = "NONE";
						}
					} else {
						if (!badArg && iptables) {
							badArg = regResult[x];
						} else if (!iptables) {
							response = regResult[0] + ": command not found";
						}
					}
				}
				var cmds:Array = [L, A, I, D, R, Eold, Pchain, F,NC];
				var cmdstr:Array = ["-L", "-A", "-I", "-D", "-R", "-E", "-P", "-F","-N"];
				
				
				if (iptables) {
					var cmd1 = "";
					var cmd2 = "";
					for (var cmd:String in cmds) {
						if (cmds[cmd] && !cmd1) {
							cmd1 = cmdstr[cmds.indexOf(cmds[cmd])];
						} else if (cmds[cmd] && cmd1 && !cmd2) {
							cmd2 = cmdstr[cmds.indexOf(cmds[cmd])];
						}
					}
					if (cmd1 && !cmd2) {
						//One command given
						if (badArg) {
							response = "Bad argument '" + badArg +"'\nTry 'iptables -h' or 'iptables --help' for more information";
						} else if (!sudo) {
							response = "iptables v1.4.21: can't initialize iptables table `filter': Permission denied (you must be root)\nPerhaps iptables or your kernel needs to be upgraded."
						} else {
							
							if (L) {
								if (chains[L] != null) {
									response += "\n";
									if (L == "ALL") {
										for (var chain:String in chains) {
											if (chain != "ALL") {
												response += "Chain " + chain +  " (policy "+chainPolicy[chain]+")    target prot opt source\t\tdestination\n";
												for (var rule:String in chains[chain]) {
													response += chains[chain][rule].toRuleString();
												}
											}
											response += "\n";
										}
									} else {
										response += "Chain " + chain +  " (policy "+chainPolicy[chain]+")    target prot opt source\t\tdestination\n";
										for (var rule:String in chains[L]) {
											response += chains[L][rule].toRuleString();
										}
									}
								} else {
									response = "iptables: No chain/target/match by that name";
								}
							} else if (A) {
								var obj = createRule(m, p, dport, sport, j, i, v, s, d, o, ctstate,A);
								var errBool = obj.error;
								var rulen:Rule = obj.rule;
								if (!errBool) {
									if (chains[A] != null) {
										chains[A].push(rulen);
									} else {
										response = "iptables: No chain/target/match by that name";
									}
								} else {
									response = errBool;
								}
							} else if (I) {
								var obj = createRule(m, p, dport, sport, j, i, v, s, d, o, ctstate,I);
								var errBool = obj.error;
								var rulen:Rule = obj.rule;
								if (!errBool) {
									if (chains[I] != null) {
										if (Inum <= chains[I].length) {
											chains[I].splice((Inum - 1), 0 , rulen);
										} else {
											response = "iptables: Index of insertion too big.";
										}
									} else {
										response = "iptables: No chain/target/match by that name";
									}
								} else {
									response = errBool;
								}
							} else if (D) {
								if (chains[D] != null) {
									if (Dnum <= chains[D].length) {
										chains[D].splice((Dnum - 1), 1);
									} else {
										response = "iptables: Index of insertion too big.";
									}
								} else {
									response = "iptables: No chain/target/match by that name";
								}
							} else if (R) {
								var obj = createRule(m, p, dport, sport, j, i, v, s, d, o, ctstate,R);
								var errBool = obj.error;
								var rulen:Rule = obj.rule;
								if (!errBool) {
									if (chains[R] != null) {
										if (Rnum == -1) {
											response = "iptables v1.4.4: -R requires a rule number\nTry 'iptables -h' or 'iptables --help' for more information";
										} else if (Rnum <= chains[R].length) {
											delete chains[R][String(Rnum - 1)]
											chains[R][String(Rnum - 1)] = rulen;
										} else {
											response = "iptables: Index of insertion too big.";
										}
									} else {
										response = "iptables: No chain/target/match by that name";
									}
								} else {
									response = errBool;
								}
							} else if (Eold) {
								if (Eold == "PROHIBITED") {
									response = "iptables v1.4.4: Cannot rename default chains\nTry 'iptables -h' or 'iptables --help' for more information";
								} else if (Eold == "REQUIRES") {
									response = "iptables v1.4.4: -E requires old-chain-name and new-chain-name\nTry 'iptables -h' or 'iptables --help' for more information";
								} else if (Eold == "NONE") {
									response = "iptables: No chain/target/match by that name";
								} else {
									var obj = chains[Eold]
									var obj2 = chainPolicy[Eold]
									delete chains[Eold]
									delete chainPolicy[Eold]
									chains[Enew] = obj;
									chainPolicy[Enew] = obj2;
								}
							} else if (Pchain) {
								if (Pchain == "BAD") {
									response = "iptables v1.4.4: Bad policy name.\nTry 'iptables -h' or 'iptables --help' for more information";
								} else if (Pchain == "REQUIRES") {
									response = "iptables v1.4.4: -P requires a chain and a policy\nTry 'iptables -h' or 'iptables --help' for more information";
								} else if (Pchain == "NONE") {
									response = "iptables: No chain/target/match by that name";
								} else {
									chainPolicy[Pchain] = Pol;
								}
							} else if (F) {
								if (F == "ALL") {
									for (var chainKey:String in chains) {
										chains[chainKey] = new Array();
									}
								} else if (chains[F] != null) {
									chains[F] = new Array();
								} else {
									response = "iptables: No chain/target/match by that name";
								}
							} else if (NC) {
								if (NC == "NONE") {
									response = "iptables v1.4.4: option '-N' requires an argument\nTry 'iptables -h' or 'iptables --help' for more information";
								} else {
									chains[NC] = new Array();
									chainPolicy[NC] = "ACCEPT";
								}
							}
							
						}
					} else if (cmd1 && cmd2) {
						response = "iptables v1.4.4: Cannot use " + cmd1 + " with " + cmd2 + "\n\nTry 'iptables -h' or 'iptables --help' for more information";
					} else {
						//No command
						if (badArg) {
							response = "Bad argument '" + badArg +"'\nTry 'iptables -h' or 'iptables --help' for more information";
						} else {
							response = "iptables v1.4.4: no command specified\nTry 'iptables -h' or 'iptables --help' for more information";
						}
					}
					if (help) {
						response = "iptables v1.4.21\n\nUsage: iptables -[ACD] chain rule-specification [options]   	\niptables -I chain [rulenum] rule-specification [options]   	\niptables -R chain rulenum rule-specification [options]\n   	iptables -D chain rulenum [options]\n   	iptables -[LS] [chain [rulenum]] [options]\n   	iptables -[FZ] [chain] [options]\n   	iptables -[NX] chain\n   	iptables -E old-chain-name new-chain-name\n   	iptables -P chain target [options]\n   	iptables -h (print this help information)\n\nCommands:\nEither long or short options are allowed.\n  --append  -A chain   	 Append to chain\n  --check   -C chain   	 Check for the existence of a rule\n  --delete  -D chain   	 Delete matching rule from chain\n  --delete  -D chain rulenum\n   			 Delete rule rulenum (1 = first) from chain\n  --insert  -I chain [rulenum]\n   			 Insert in chain as rulenum (default 1=first)\n  --replace -R chain rulenum\n   			 Replace rule rulenum (1 = first) in chain\n  --list	-L [chain [rulenum]]\n   			 List the rules in a chain or all chains\n  --list-rules -S [chain [rulenum]]\n   			 Print the rules in a chain or all chains\n  --flush   -F [chain]   	 Delete all rules in  chain or all chains\n  --zero	-Z [chain [rulenum]]\n  			 Zero counters in chain or all chains\n  --new 	-N chain   	 Create a new user-defined chain\n  --delete-chain\n        	-X [chain]   	 Delete a user-defined chain\n  --policy  -P chain target\n   			 Change policy on chain to target\n  --rename-chain\n        	-E old-chain new-chain\n   			 Change chain name, (moving any references)\nOptions:\n	--ipv4    -4   	 Nothing (line is ignored by ip6tables-restore)\n	--ipv6    -6   	 Error (line is ignored by iptables-restore)\n[!] --protocol    -p proto    protocol: by number or name, eg. `tcp'\n[!] --source    -s address[/mask][...]\n   			 source specification\n[!] --destination -d address[/mask][...]\n   			 destination specification\n[!] --in-interface -i input name[+]\n   			 network interface name ([+] for wildcard)\n --jump    -j target\n   			 target for rule (may load target extension)\n  --goto  	-g chain\n                          	jump to chain with no return\n  --match    -m match\n   			 extended match (may load extension)\n  --numeric    -n   	 numeric output of addresses and ports\n[!] --out-interface -o output name[+]\n   			 network interface name ([+] for wildcard)\n  --table    -t table    table to manipulate (default: `filter')\n  --verbose    -v   	 verbose mode\n  --wait    -w [seconds]    wait for the xtables lock\n  --line-numbers   	 print line numbers when listing\n  --exact    -x   	 expand numbers (display exact values)\n[!] --fragment    -f   	 match second or further fragments only\n  --modprobe=<command>   	 try to insert modules using this command\n  --set-counters PKTS BYTES    set the counter during insert/append\n[!] --version    -V   	 print package version."
					}
					updateFWText();
				}
				if (response) {
					var lines = response.split("\n").length
					var termPreSym = new TextField();
					mcTerminalPane.addChild(termPreSym);
					termPreSym.width = 20;
					termPreSym.height = 20;
					termPreSym.x = 5;
					termPreSym.y = currentTerminalY;
					termPreSym.border = false
					termPreSym.type = TextFieldType.DYNAMIC;
					termPreSym.text = ">";
					termPreSym.textColor = 0xFFFFFF;
					mcTerminalPane.addChild(termPreSym);

					newLine = new TextField();
					mcTerminalPane.addChild(newLine);
					newLine.width = 450;
					newLine.height = 20 + (15 * lines-1);
					newLine.x = 25;
					newLine.y = currentTerminalY;
					newLine.border = false
					newLine.type = TextFieldType.DYNAMIC;
					newLine.text = response;
					newLine.textColor = 0xFFFFFF;

					currentTerminalY = currentTerminalY + 5 + (15 * lines - 1);
				}
		}
		
		private function createRule(m:String, p:String, dport:String, sport:String, j:String, i:String, v:Boolean, s:String, d:String, o:String, ctstate:String, chain:String):Object
		{
			var prot:String = "all";
			var target:String = "";
			var source:String = "anywhere";
			var destination:String = "anywhere";
			var opt:String = "--";
			var iface = "";
			var oface = "";
			var x:String = "";
			var ssport = "";
			var ddport = "";
			
			var NEW = false;
			var RELATED = false;
			var ESTABLISHED = false;
			var INVALID = false;
			
			var error = "";
			
			if (m) {
				if (m == "conntrack") {
					if (!ctstate) {				
						error = "iptables v1.4.4: conntrack: At least one option is required\nTry 'iptables -h' or 'iptables --help' for more information";
					}
				} else {
					error = "iptables v1.4.4: conntrack: At least one option is required\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (p) {
				var proto = p.toLowerCase();
				if (proto == "tcp" || proto == "udp" || proto == "udplite" || proto == "icmp" || proto == "esp" || proto == "ah" || proto == "sctp" || proto == "ipv6") {
					prot = proto
				} else {
					error = "iptables v1.4.4: unknown protocol '" + p + "' specified\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (sport) {
				if (prot == "tcp" || prot == "udp") {
					if (!(isNaN(Number(sport))) && Number(sport) < 5000) {
						x = prot + " spt:" + sport
						ssport = sport
					} else if (sport == "www" || sport == "ssh") {
						x = prot + " spt:" + sport
					} else if (sport.split(":").length == 2) {
						var port1 = sport.split(":")[0];
						var port2 = sport.split(":")[1];
						if (!(isNaN(Number(port1))) && Number(port1) < 5000 && !(isNaN(Number(port2))) && Number(port2) < 5000) {
							if (port1 > port2) {
								error = "iptables v1.4.4: invalid portrange (min > max)\nTry 'iptables -h' or 'iptables --help' for more information";
							} else {
								x = prot + " spts:" + port1 + ":" + port2 + " "
								ssport = port1 + ":" + port2
							}
						} else {
							error = "iptables v1.4.4: invalid port/service '" + sport + "' specified\nTry 'iptables -h' or 'iptables --help' for more information";
						}
					} else {
						error = "iptables v1.4.4: invalid port/service '" + sport + "' specified\nTry 'iptables -h' or 'iptables --help' for more information";
					}
				}
			}
			if (dport) {
				if (prot == "tcp" || prot == "udp") {
					if (!(isNaN(Number(dport))) && Number(dport) < 5000) {
						x += " " + prot + " dpt:" + dport
						ddport = dport
					} else if (dport == "www" || dport == "ssh") {
						x += " " +prot + " dpt:" + dport
					} else if (dport.split(":").length == 2) {
						var port1 = dport.split(":")[0];
						var port2 = dport.split(":")[1];
						if (!(isNaN(Number(port1))) && Number(port1) < 5000 && !(isNaN(Number(port2))) && Number(port2) < 5000) {
							if (port1 > port2) {
								error = "iptables v1.4.4: invalid portrange (min > max)\nTry 'iptables -h' or 'iptables --help' for more information";
							} else {
								x += " " +prot + " dpts:" + port1 + ":" + port2 + " "
								ddport = port1 + ":" + port2
							}
						} else {
							error = "iptables v1.4.4: invalid port/service '" + dport + "' specified\nTry 'iptables -h' or 'iptables --help' for more information";
						}
					} else {
						error = "iptables v1.4.4: invalid port/service '" + dport + "' specified\nTry 'iptables -h' or 'iptables --help' for more information";
					}
				}
			}
			if (j) {
				if (j == "ACCEPT" || j == "REJECT" || j == "DROP" || j == "LOG" || chains[j]) {
					target = j		//log level warning on x? 
				} else {
					error = "iptables v1.4.4: Couldn't load target '" + p + "':/lib/xtables/libipt_drop.so: \ncannot open shared object file: No such file or directory\n\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (i) {
				if (chain == "INPUT" || chain == "FORWARD") {
					iface = i;
				} else {
					error = "iptables v1.4.4: Can't use -i with " + chain + "\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (v) {
				trace("v not implemented")
			}
			if (s) {
				var sp = s.split(".");
				if (sp.length == 4 && !(isNaN(Number(sp[0]))) && !(isNaN(Number(sp[1])))&& !(isNaN(Number(sp[2])))&& !(isNaN(Number(sp[3])))) {
					if (Number(sp[0]) > 255 || Number(sp[1]) > 255 || Number(sp[2]) > 255 || Number(sp[3]) > 255) {
						error = "iptables v1.4.4: host/network '" + s + "' out of range\nTry 'iptables -h' or 'iptables --help' for more information";
					} else {
						source = s;
					}
				} else if (!isNaN(Number(s))) {
					var num:int = Number(s)
					var bytes:Array = new Array();
					bytes[0] = num & 0xFF;
					bytes[1] = (num >> 8) & 0xFF;
					bytes[2] = (num >> 16) & 0xFF;
					bytes[3] = (num >> 24) & 0xFF; 
					source = bytes.join(".");
				} else {
					error = "iptables v1.4.4: host/network '" + s + "' not found\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (d) {
				var sp = d.split(".");
				if (sp.length == 4 && !(isNaN(Number(sp[0]))) && !(isNaN(Number(sp[1])))&& !(isNaN(Number(sp[2])))&& !(isNaN(Number(sp[3])))) {
					if (Number(sp[0]) > 255 || Number(sp[1]) > 255 || Number(sp[2]) > 255 || Number(sp[3]) > 255) {
						error = "iptables v1.4.4: host/network '" + d + "' out of range\nTry 'iptables -h' or 'iptables --help' for more information";
					} else {
						destination = d;
					}
				} else if (!isNaN(Number(d))) {
					var num:int = Number(d)
					var bytes:Array = new Array();
					bytes[0] = num & 0xFF;
					bytes[1] = (num >> 8) & 0xFF;
					bytes[2] = (num >> 16) & 0xFF;
					bytes[3] = (num >> 24) & 0xFF; 
					destination = bytes.join(".");
				} else {
					error = "iptables v1.4.4: host/network '" + d + "' not found\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (o) {
				if (chain == "OUTPUT" || chain == "FORWARD") {
					oface = o;
				} else {
					error = "iptables v1.4.4: Can't use -o with " + chain + "\nTry 'iptables -h' or 'iptables --help' for more information";
				}
			}
			if (ctstate) {
				if (m != "conntrack") {
					error = "iptables v1.4.4: unknown option '--ctstate'\nTry 'iptables -h' or 'iptables --help' for more information";
				} else {
					var states:Array = ctstate.split(",");
					var bad:String = "";
					for (var ii:int = 0; ii< states.length; ii++) {
						if (states[ii] == "RELATED") {
							RELATED = true;
						} else if (states[ii] == "ESTABLISHED") {
							ESTABLISHED = true;
						}  else if (states[ii] == "INVALID") {
							INVALID = true;
						}  else if (states[ii] == "NEW") {
							NEW = true;
						} else {
							bad = states[ii]
						}
					}
					if (!bad) {
						x += " ctstate " + states.join(",");
					} else {
						error = "iptables v1.4.4: Bad ctstate '" +bad + "'\nTry 'iptables -h' or 'iptables --help' for more information";
					}
				}

			}

			var newRule:Rule = new Rule(target, prot, opt, source, destination, x,iface,ssport,ddport,oface,NEW,RELATED,ESTABLISHED,INVALID);
			var rtrn = new Object();
			rtrn.error = error;
			rtrn.rule = newRule;
			return rtrn;
		}
		
		private function finishLevel(e:MouseEvent):void 
		{
			var feedback:String = "";
			var level:Object = levels[currLevel];
			var testpkts:Array = level.answer;
			fail = false;
			for (var pkt:String in testpkts) {
				var packet:Packet = testpkts[pkt];
				var ans:String = packet.answer[0];
				var outcome:String = "";
				if (!chains[packet.table]) {
					feedback += "<font color=\"#DC143C\">"
					feedback += "    Test Packet (" + (Number(pkt) + 1) + "/" +testpkts.length + ") "
					feedback += " was sent to invalid target " + packet.table + "\n";
					feedback += "</font>"
					trace("hey");
					fail = true;
					continue;
				}
				for (var ruleKey:String in chains[packet.table]) {
					var rtrn = (chains[packet.table][ruleKey] as Rule).outcome(packet);
					if (rtrn != "UNMATCHED") {
						outcome = rtrn;
						break;
					}
				}
				if (outcome == "") {
					var out:String = chainPolicy[packet.table];
					if (ans != out) {
						feedback += "<font color=\"#DC143C\">"
						feedback += "    Test Packet (" + (Number(pkt) + 1) + "/" +testpkts.length + ") "
						if (packet.NEW || packet.RELATED || packet.ESTABLISHED || packet.INVALID) {
							feedback += "with state: "
							if (packet.NEW) {
								feedback += "NEW "
							}
							if (packet.RELATED) {
								feedback += "RELATED "
							}
							if (packet.ESTABLISHED) {
								feedback += "ESTABLISHED "
							}
							if (packet.INVALID) {
								feedback += "INVALID "
							}
						}
						if (packet.source) {
							feedback += "with source: " + packet.source
						}
						if (packet.destination) {
							feedback += " , destination: " + packet.destination
						}
						if (packet.protocol) {
							feedback += " , protocol: " + packet.protocol
						}
						if (packet.dport) {
							feedback += " , destination port: " + packet.dport
						}
						if (packet.sport) {
							feedback += " , source port: " + packet.sport
						}
						if (packet.table) {
							feedback += " at the " + packet.table + " chain"
						}
						if (packet.iface) {
							feedback += " from interface " + packet.iface
						}
						if (packet.oface) {
							feedback += " to output interface " + packet.oface
						}
						feedback += " was sent to target " + out + " instead of " + ans + "\n";
						feedback += "</font>"
						trace("hey");
						fail = true;
					} else {
						feedback += "<font color=\"#228B22\">"
						feedback += "    Test Packet (" + (Number(pkt) + 1) + "/" +testpkts.length + ") "
						if (packet.NEW || packet.RELATED || packet.ESTABLISHED || packet.INVALID) {
							feedback += "with state: "
							if (packet.NEW) {
								feedback += "NEW "
							}
							if (packet.RELATED) {
								feedback += "RELATED "
							}
							if (packet.ESTABLISHED) {
								feedback += "ESTABLISHED "
							}
							if (packet.INVALID) {
								feedback += "INVALID "
							}
						}
						if (packet.source) {
							feedback += "with source: " + packet.source
						}
						if (packet.destination) {
							feedback += " , destination: " + packet.destination
						}
						if (packet.protocol) {
							feedback += " , protocol: " + packet.protocol
						}
						if (packet.dport) {
							feedback += " , destination port: " + packet.dport
						}
						if (packet.sport) {
							feedback += " , source port: " + packet.sport
						}
						if (packet.table) {
							feedback += " at the " + packet.table + " chain"
						}
						if (packet.iface) {
							feedback += " from input interface " + packet.iface
						}
						if (packet.oface) {
							feedback += " to output interface " + packet.oface
						}
						feedback += " was sent to target " + ans + " correctly\n";
						feedback += "</font>"
					}
				} else if (ans == outcome) {
						feedback += "<font color=\"#228B22\">"
						feedback += "    Test Packet (" + (Number(pkt) + 1) + "/" +testpkts.length + ") "
						if (packet.NEW || packet.RELATED || packet.ESTABLISHED || packet.INVALID) {
							feedback += "with state: "
							if (packet.NEW) {
								feedback += "NEW "
							}
							if (packet.RELATED) {
								feedback += "RELATED "
							}
							if (packet.ESTABLISHED) {
								feedback += "ESTABLISHED "
							}
							if (packet.INVALID) {
								feedback += "INVALID "
							}
						}
						if (packet.source) {
							feedback += "with source: " + packet.source
						}
						if (packet.destination) {
							feedback += " , destination: " + packet.destination
						}
						if (packet.protocol) {
							feedback += " , protocol: " + packet.protocol
						}
						if (packet.dport) {
							feedback += " , destination port: " + packet.dport
						}
						if (packet.sport) {
							feedback += " , source port: " + packet.sport
						}
						if (packet.table) {
							feedback += " at the " + packet.table + " chain"
						}
						if (packet.iface) {
							feedback += " from interface " + packet.iface
						}
						if (packet.oface) {
							feedback += " to output interface " + packet.oface
						}
						feedback += " was sent to target " + ans + " correctly\n";
						feedback += "</font>"
				} else if (ans != outcome) {
						feedback += "<font color=\"#DC143C\">"
						feedback += "    Test Packet (" + (Number(pkt) + 1) + "/" +testpkts.length + ") "
						if (packet.NEW || packet.RELATED || packet.ESTABLISHED || packet.INVALID) {
							feedback += "with state: "
							if (packet.NEW) {
								feedback += "NEW "
							}
							if (packet.RELATED) {
								feedback += "RELATED "
							}
							if (packet.ESTABLISHED) {
								feedback += "ESTABLISHED "
							}
							if (packet.INVALID) {
								feedback += "INVALID "
							}
						}
						if (packet.source) {
							feedback += "with source: " + packet.source
						}
						if (packet.destination) {
							feedback += " , destination: " + packet.destination
						}
						if (packet.protocol) {
							feedback += " , protocol: " + packet.protocol
						}
						if (packet.dport) {
							feedback += " , destination port: " + packet.dport
						}
						if (packet.sport) {
							feedback += " , source port: " + packet.sport
						}
						if (packet.table) {
							feedback += " at the " + packet.table + " chain"
						}
						if (packet.iface) {
							feedback += " from interface " + packet.iface
						}
						if (packet.oface) {
							feedback += " to output interface " + packet.oface
						}
						feedback += " was sent to target " + outcome + " instead of " + ans + "\n";
						feedback += "</font>"
						fail = true;
				}
			}
			if (!fail) {
				if (levels[currLevel].successfeedback) {
					feedback = levels[currLevel].successfeedback
				} else {
					feedback = "Hi, \n\n That seems to have done the trick! Here's what I tested and what you got right:\n\n" + feedback + "\n\nThere is plenty more to do so get back to work\n\nB,"
				}
			}
			if (fail && levels[currLevel].failfeedback) {
					feedback = levels[currLevel].failfeedback + feedback + "\n\nB,";
			} else if (fail) {
				feedback = "Hi, \n\n Unfortunately your solution has not solved the problem. Take another look at the breifing and then restart or continue to try again.\n\n A summary of what went wrong can be found below: \n\n" + feedback + "\n\nB,"
			}
			//feedback
			mcFeedbackText.htmlText = feedback;
			showScreen("FEED");

		}
		
		private function updateFWText():void {
			var txt = "				                                       	<font size=\"13\"><B>Firewall Rules</B></font size=\"13\">\n\n"
			for (var chain:String in chains) {
					if (chain != "ALL") {
						txt += "Chain " + chain +  " (policy "+chainPolicy[chain]+")\ntarget               prot opt source\t        destination\n";
						for (var rule:String in chains[chain]) {
							txt += (chains[chain][rule] as Rule).toRuleString();
						}
						txt += "\n";
					}
			}
			mcFirewallText.htmlText = txt
		}
		
		function clone(source:Object):* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			return(copier.readObject());
		}
		
		private function setupLevels():void 
		{
				var level1 = new Object();
				var level2 = new Object();
				var level3 = new Object();
				var level4 = new Object();
				var level5 = new Object();
				var level6 = new Object();
				var level7 = new Object();
				var level8 = new Object();
				var level9 = new Object();
				var level10 = new Object();
				var level11 = new Object();
				var level12 = new Object();
				var level13 = new Object();
				var level14 = new Object();
				var level15 = new Object();
				var level16 = new Object();
				var level17 = new Object();
				var level18 = new Object();
				var level19 = new Object();
				var level20 = new Object();
				var level21 = new Object();
				var level22 = new Object();
				var level23 = new Object();
				var level24 = new Object();
				var level25 = new Object();

				
				level1.briefing_easy = "Hi,\n\n   We have an urgent issue with the firewall, none of the staff can access the internet at all. Before you worry about safety I need you to get us back online immediately.\n\n<font size=\"13\"><B>  It seems like the policy for the firewalls INPUT and OUTPUT tables have been set to DROP so all incoming and outgoing packets are dropped by default.</B> </font size=\"13\">\n\n  You need to either change the default policy for these chains or add sufficient rules to allow internet access, \n\n  To edit the firewall you will need superuser privilege, which is gained by using “sudo” before the desired command.\n\n  To edit the firewall use the “iptables” flag followed by a series of commands and corresponding parameters. For example to change a chains default policy use the “-P” or “--policy” command followed by the chain name and desired default policy, valid policies are “DROP” , “ACCEPT” and “REJECT” \n\n<font size=\"13\"><B>   sudo iptables -P INPUT ACCEPT</B> </font size=\"13\">\n\n  To learn more about more commands or command structure you can use the “-h” or “--help” command i.e:\n\n<font size=\"13\"><B>   sudo iptables --help</B></font size=\"13\">\n\n  Once you are happy with the changes you have made to the firewall, click the “Submit” button to see if you have completed the task.\n\nB,";
				level1.briefing_medium = "Hi,\n\n    The firewall seems to be blocking the internet access for the office, we need this fixed right away\n\n  <font size=\"13\"><B>I suggest looking at the OUTPUT and INPUT table's default policy </B></font size=\"13\"> or adding some rules to the chains to allow traffic in and out, don’t worry about security at the moment \n\n  Try using <font size=\"13\"><B>-L </B></font size=\"13\">to list current rules and table policy, <font size=\"13\"><B>-A</B></font size=\"13\"> to append a rule to a table and <font size=\"13\"><B>-P</B></font size=\"13\"> to change a tables policy if needed, Don't forget to try <font size=\"13\"><B>--help</B></font size=\"13\"> for some information on how to use the iptable commands\n\n  <font size=\"13\"><B> To edit the firewall you will need superuser privilege, remember to type sudo before the 'iptables' command.\</B></font size=\"13\">\n\n   Once you are happy with the changes you have made to the firewall, click the “Submit” button to see if you have completed the task. \n\nB,";
				level1.briefing_hard = "Hi,\n\n	What's going on?\n\n  I can't get on the internet at all!\n\n  First day on the job and you've broken everything! \n\n  You better fix this immediately \n\nB,";
										//src	       dst    	sport dport	proto	ans		chain	chainsforstart
				var ans1_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans1_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT","");
				level1.answer = [ans1_1, ans1_2];
				var chainslvl1 = new Dictionary();
				var chainPolicylvl1 = new Dictionary();
				chainslvl1["INPUT"] = new Array();
				chainPolicylvl1["INPUT"] = "DROP";
				chainslvl1["FORWARD"] = new Array();
				chainPolicylvl1["FORWARD"] = "ACCEPT";
				chainslvl1["OUTPUT"] = new Array();
				chainPolicylvl1["OUTPUT"] = "DROP";
				chainslvl1["ALL"] = new Array();
				level1.chains = chainslvl1
				level1.chainsPolicy = chainPolicylvl1
				levels.push(level1);
				

				level2.briefing_easy = "Hi,\n\n   We are vulnerable to all malicious hackers out there, we need some protection.\n\n   I want you to update the firewall such that only incoming TCP packets on ports 80 and 443 are accepted and all others are dropped\n\n   To add a rule to a chain use the “-A” or “--append” command followed by the chain name on which the rule should be added, and also followed by a range of options which define the rule. For example the option “-j” or “--jump” tells the rule what to do with a packet that is a match with the main section of the rule, by default iptables allows four targets: “ACCEPT”, “REJECT”, “DROP” and “LOG”. Options for the rule include “-p” or “--proto” which specifies the protocol and “--dport” specifies the destination port, these options are used to match corresponding packets i.e:\n\n   <font size=\"13\"><B> sudo iptables -A INPUT -j ACCEPT --dport 80 -p tcp</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level2.briefing_medium = "Hi,\n\n   We are vulnerable to all malicious hackers out there, we need some protection.\n\n   I want you to update the firewall such that only incoming TCP packets on ports 80 and 443 are accepted and all others are dropped\n\n   <font size=\"13\"><B>Try to use the insert “-I” or append “-A” commands along with “--dport” destination port, “-p” protocol and “-j” jump options to create your rules.</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level2.briefing_hard = "Hi,\n\n   We are vulnerable to all malicious hackers out there, we need some protection.\n\n   I want you to update the firewall such that only incoming TCP packets on ports 80 and 443 are accepted and all others are dropped\n\n   \n\nB,"
				var ans2_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans2_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans2_3 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "INPUT","");
				var ans2_4 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "INPUT","");
				level2.answer = [ans2_1,ans2_2,ans2_3,ans2_4];
				levels.push(level2);
				
				
				level3.briefing_easy = "Hi,\n\n   I’m still not sold you’re the person for the job, I’ve tinkered with the firewall a little bit, let’s see if you can get things working correctly again!\n\n Use “-D” or “—delete” to remove a rule: \n\n    <font size=\"13\"><B>sudo iptables -D INPUT 3</B></font size=\"13\">\n\nB,";
				level3.briefing_medium = "Hi,\n\n   I’m still not sold you’re the person for the job, I’ve tinkered with the firewall a little bit, let’s see if you can get things working correctly again!\n\n Use “-D” or “—delete” to remove a rule.\n\nB,";
				level3.briefing_hard = "Hi,\n\n   I’m still not sold you’re the person for the job, I’ve tinkered with the firewall a little bit, let’s see if you can get things working correctly again!\n\nB,";
				var chainslvl3 = new Dictionary();
				var chainPolicylvl3 = new Dictionary();
				chainslvl3["INPUT"] = new Array();
				chainPolicylvl3["INPUT"] = "ACCEPT";
				chainslvl3["FORWARD"] = new Array();
				chainPolicylvl3["FORWARD"] = "DROP";
				chainslvl3["OUTPUT"] = new Array();
				chainPolicylvl3["OUTPUT"] = "ACCEPT";
				chainslvl3["ALL"] = new Array();  //target //proto //opt // source /dest //x iface port
				chainslvl3["INPUT"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "", "",""))
				chainslvl3["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80","","","80"))
				chainslvl3["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","","443"))
				chainslvl3["INPUT"].push(new Rule("DROP", "all", "", "anywhere", "anywhere", "", "", "",""))
				var ans3_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans3_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans3_3 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "INPUT","");
				var ans3_4 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "INPUT","");
				level3.answer = [ans3_1,ans3_2,ans3_3,ans3_4];
				level3.chains = chainslvl3
				level3.chainsPolicy = chainPolicylvl3
				levels.push(level3);
				
				level4.briefing_easy = "Hi,\n\n   If you’re going to work here I value efficiency, I want you to again fix the firewall that I have broken, but this time try to do it with as few commands as you can manage.  Use “-F” or “--flush” to delete all rules or all rules in a chain:\n\n<font size=\"13\"><B>sudo iptables -F OUTPUT</B></font size=\"13\">\n\nB,";
				level4.briefing_medium = "Hi,\n\n   If you’re going to work here I value efficiency, I want you to again fix the firewall that I have broken, but this time try to do it with as few commands as you can manage.  Use “-F” or “--flush” to delete all rules or all rules in a chain. \n\nB,";
				level4.briefing_hard = "Hi,\n\n   If you’re going to work here I value efficiency, I want you to again fix the firewall that I have broken, but this time try to do it with as few commands as you can manage.\n\nB,";
				var chainslvl4 = new Dictionary();
				var chainPolicylvl4 = new Dictionary();
				chainslvl4["INPUT"] = new Array();
				chainPolicylvl4["INPUT"] = "ACCEPT";
				chainPolicylvl4["FORWARD"] = "DROP";
				chainslvl4["OUTPUT"] = new Array();
				chainslvl4["FORWARD"] = new Array();
				chainPolicylvl4["OUTPUT"] = "ACCEPT";
				chainslvl4["ALL"] = new Array();  //target //proto //opt // source /dest //x iface port
				chainslvl4["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80","","","80"))
				chainslvl4["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","","443"))
				chainslvl4["INPUT"].push(new Rule("DROP", "all", "", "anywhere", "anywhere", "", "", "",""))
				chainslvl4["OUTPUT"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["OUTPUT"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["OUTPUT"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["OUTPUT"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["OUTPUT"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["FORWARD"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["FORWARD"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","",""))
				chainslvl4["FORWARD"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","", ""))
				chainslvl4["FORWARD"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","", ""))
				chainslvl4["FORWARD"].push(new Rule("REJECT", "all", "", "anywhere", "anywhere", "", "","", ""))
				var ans4_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans4_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans4_3 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "INPUT","");
				var ans4_4 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "INPUT", "");
				var ans4_5 = new Packet("8.8.8.8", "8.8.8.8", "", "22", "tcp", ["ACCEPT"], "OUTPUT","");
				var ans4_6 = new Packet("10.10.10.10", "20.20.20.20", "", "13", "tcp", ["DROP"], "FORWARD","");
				level4.chains = chainslvl4
				level4.chainsPolicy = chainPolicylvl4
				level4.answer = [ans4_1,ans4_2,ans4_3,ans4_4,ans4_5,ans4_6];
				levels.push(level4);
				
				
				
				level5.briefing_easy = "Hi,\n\n   I want you to update the firewall such that only incoming TCP packets on ports 77 and 222 are accepted and all others are dropped\n\n   To add a rule to a chain use the “-A” or “--append” command followed by the chain name on which the rule should be added, and also followed by a range of options which define the rule. For example the option “-j” or “--jump” tells the rule what to do with a packet that is a match with the main section of the rule, by default iptables allows four targets: “ACCEPT”, “REJECT”, “DROP” and “LOG”. Options for the rule include “-p” or “--proto” which specifies the protocol and “--dport” specifies the destination port, these options are used to match corresponding packets i.e:\n\n   <font size=\"13\"><B> sudo iptables -A INPUT -j ACCEPT --dport 80 -p tcp</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level5.briefing_medium = "Hi,\n\n   I want you to update the firewall such that only incoming TCP packets on ports 77 and 222 are accepted and all others are dropped\n\n   <font size=\"13\"><B>Try to use the insert “-I” or append “-A” commands along with “--dport” destination port, “-p” protocol and “-j” jump options to create your rules.</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level5.briefing_hard = "Hi,\n\n    I want you to update the firewall such that only incoming TCP packets on ports 77 and 222 are accepted and all others are dropped\n\n   \n\nB,"
				var ans5_1 = new Packet("139.130.4.5", "8.8.8.8", "", "77", "tcp", ["ACCEPT"], "INPUT","");
				var ans5_2 = new Packet("139.130.4.5", "8.8.8.8", "", "222", "tcp", ["ACCEPT"], "INPUT", "");
				var ans5_3 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "INPUT","");
				var ans5_4 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "INPUT","");
				level5.answer = [ans5_1,ans5_2,ans5_3,ans5_4];
				levels.push(level5);
				
				var chainslvl6 = new Dictionary();
				var chainPolicylvl6 = new Dictionary();
				chainslvl6["INPUT"] = new Array();
				chainslvl6["OUTPUT"] = new Array();
				chainslvl6["FORWARD"] = new Array();
				chainPolicylvl6["INPUT"] = "ACCEPT";
				chainPolicylvl6["FORWARD"] = "DROP";
				chainPolicylvl6["OUTPUT"] = "ACCEPT";
				level6.briefing_easy = "Hi,\n\n    One of the staffers needs to use SMP and as such inserted a rule into the INPUT chain.\n\n   It seems like they used the incorrect port number, SMP by default runs on port <font size=\"13\"><B>446</B></font size=\"13\"> use the “-R” or “--replace” command to change the incorrect rule to the correct rule with the appropriate port i.e:\n\n<font size=\"13\"><B>sudo iptables -R 5 --dport 123 -j ACCEPT -p tcp</B></font size=\"13\">\n\nB,";;
				level6.briefing_medium = "Hi,\n\n    One of the staffers needs to use SMP and as such inserted a rule into the INPUT chain.\n\n   It seems like they used the incorrect port number, SMP by default runs on port <font size=\"13\"><B>445</B></font size=\"13\"> use the “-R” or “--replace” command to change the incorrect rule to the correct rule with the appropriate port.\n\nB,";;
				level6.briefing_hard = "Hi,\n\n    One of the staffers needs to use SMP and as such inserted a rule into the INPUT chain.\n\n   It seems like they used the incorrect port number, SMP by default runs on port <font size=\"13\"><B>445</B></font size=\"13\"> use the replace command to change the incorrect rule to the correct rule with the appropriate port.\n\nB,";;
				chainslvl6["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80", "","", "80"))
				chainslvl6["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:111","","","111"))
				chainslvl6["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","","443"))
				chainslvl6["INPUT"].push(new Rule("DROP", "all", "", "anywhere", "anywhere", "", "","", ""))
				var ans6_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans6_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans6_5 = new Packet("139.130.4.5", "8.8.8.8", "", "455", "tcp", ["ACCEPT"], "INPUT", "");
				var ans6_6 = new Packet("139.130.4.5", "8.8.8.8", "", "111", "tcp", ["DROP"], "INPUT", "");
				var ans6_3 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "INPUT","");
				var ans6_4 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "INPUT","");
				level6.chains = chainslvl6
				level6.chainsPolicy = chainPolicylvl6
				level6.answer = [ans6_1,ans6_2,ans6_3,ans6_4,ans6_5,ans6_6];
				levels.push(level6);
				

				var chainslvl7 = new Dictionary();
				var chainPolicylvl7 = new Dictionary();
				chainslvl7["INPUT"] = new Array();
				chainslvl7["OUTPUT"] = new Array();
				chainslvl7["FORWARD"] = new Array();
				chainPolicylvl7["INPUT"] = "ACCEPT";
				chainPolicylvl7["FORWARD"] = "DROP";
				chainPolicylvl7["OUTPUT"] = "DROP";
				level7.briefing_easy = "Hi,\n\n   Blocking outbound traffic is of benefit in limiting what an attacker can do once they've compromised a system on the network.\n\n   As such I’d like to move forward with a default policy change of drop on our OUTPUT chain.\n\n I’ve added the policy change already I need you to add the output rules of the corresponding input rules that you have previously implemented.\n\n   Remember that for outgoing rules we can use “--sport” to specify the source port:\n\n    <font size=\"13\"><B>sudo iptables -A  OUTPUT –j ACCEPT –p tcp –sport 80</B></font size=\"13\">\n\nB,";
				level7.briefing_medium = "Hi,\n\n   Blocking outbound traffic is of benefit in limiting what an attacker can do once they've compromised a system on the network.\n\n   As such I’d like to move forward with a default policy change of drop on our OUTPUT chain.\n\n I’ve added the policy change already I need you to add the output rules of the corresponding input rules that you have previously implemented.\n\n   Remember that for outgoing rules we can use “--sport” to specify the source port.\n\nB,";
				level7.briefing_hard = "Hi,\n\n   Blocking outbound traffic is of benefit in limiting what an attacker can do once they've compromised a system on the network.\n\n   As such I’d like to move forward with a default policy change of drop on our OUTPUT chain.\n\n I’ve added the policy change already I need you to add the output rules of the corresponding input rules that you have previously implemented.\n\nB,";
				chainslvl7["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80", "", "","80"))
				chainslvl7["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:455","","","455"))
				chainslvl7["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","","443"))
				chainslvl7["INPUT"].push(new Rule("DROP", "all", "", "anywhere", "anywhere", "", "","", ""))
				var ans7_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans7_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans7_3 = new Packet("139.130.4.5", "8.8.8.8", "", "455", "tcp", ["ACCEPT"], "INPUT", "");
				var ans7_4 = new Packet("139.130.4.5", "8.8.8.8", "80", "", "tcp", ["ACCEPT"], "OUTPUT","");
				var ans7_5 = new Packet("139.130.4.5", "8.8.8.8", "443", "", "tcp", ["ACCEPT"], "OUTPUT", "");
				var ans7_6 = new Packet("139.130.4.5", "8.8.8.8", "455", "", "tcp", ["ACCEPT"], "OUTPUT", "");
				level7.chains = chainslvl7
				level7.chainsPolicy = chainPolicylvl7
				level7.answer = [ans7_1,ans7_2,ans7_3,ans7_4,ans7_5,ans7_6];
				levels.push(level7);
				
				
				level8.briefing_easy = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets on port 15 is accepted\n\n   To add a rule to a chain use the “-A” or “--append” command followed by the chain name on which the rule should be added, and also followed by a range of options which define the rule. For example the option “-j” or “--jump” tells the rule what to do with a packet that is a match with the main section of the rule, by default iptables allows four targets: “ACCEPT”, “REJECT”, “DROP” and “LOG”. Options for the rule include “-p” or “--proto” which specifies the protocol and “--dport” specifies the destination port, these options are used to match corresponding packets i.e:\n\n   <font size=\"13\"><B> sudo iptables -A INPUT -j ACCEPT --dport 80 -p tcp</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level8.briefing_medium = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets on port 15 is accepted\n\n   <font size=\"13\"><B>Try to use the insert “-I” or append “-A” commands along with “--dport” destination port, “-p” protocol and “-j” jump options to create your rules.</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level8.briefing_hard = "Hi,\n\n    I want you to update the firewall such that outgoing TCP packets on port 15 is accepted\n\n   \n\nB,"
				var ans8_1 = new Packet("139.130.4.5", "8.8.8.8", "", "15", "tcp", ["ACCEPT"], "OUTPUT","");
				var ans8_2 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "OUTPUT","");
				var ans8_3 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "OUTPUT","");
				level8.answer = [ans8_1,ans8_2,ans8_3];
				levels.push(level8);
				
				
				
				level9.briefing_easy = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets to the IP address 123.123.123.123 are dropped, people need to stop wasting time on that website...\n\n   To add a rule to a chain use the “-A” or “--append” command followed by the chain name on which the rule should be added, and also followed by a range of options which define the rule. For example the option “-j” or “--jump” tells the rule what to do with a packet that is a match with the main section of the rule, by default iptables allows four targets: “ACCEPT”, “REJECT”, “DROP” and “LOG”. Options for the rule include “-p” or “--proto” which specifies the protocol and “--dport” specifies the destination port, these options are used to match corresponding packets i.e:\n\n   <font size=\"13\"><B> sudo iptables -A INPUT -j ACCEPT --dport 80 -p tcp</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level9.briefing_medium = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets to the IP address 123.123.123.123 are dropped, people need to stop wasting time on that website...\n\n   <font size=\"13\"><B>Try to use the insert “-I” or append “-A” commands along with “--dport” destination port, “-p” protocol and “-j” jump options to create your rules.</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level9.briefing_hard = "Hi,\n\n    I want you to update the firewall such that outgoing TCP packets to the IP address 123.123.123.123 are dropped, people need to stop wasting time on that website...\n\n   \n\nB,"
				var ans9_1 = new Packet("139.130.4.5", "123.123.123.123", "", "80", "tcp", ["DROP"], "OUTPUT","");
				var ans9_2 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "OUTPUT","");
				level9.answer = [ans9_1,ans9_2];
				levels.push(level9);
				
				
				level10.briefing_easy = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets to the port 50 are dropped\n\n   To add a rule to a chain use the “-A” or “--append” command followed by the chain name on which the rule should be added, and also followed by a range of options which define the rule. For example the option “-j” or “--jump” tells the rule what to do with a packet that is a match with the main section of the rule, by default iptables allows four targets: “ACCEPT”, “REJECT”, “DROP” and “LOG”. Options for the rule include “-p” or “--proto” which specifies the protocol and “--dport” specifies the destination port, these options are used to match corresponding packets i.e:\n\n   <font size=\"13\"><B> sudo iptables -A INPUT -j ACCEPT --dport 80 -p tcp</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level10.briefing_medium = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets to the port 50 are dropped\n\n   <font size=\"13\"><B>Try to use the insert “-I” or append “-A” commands along with “--dport” destination port, “-p” protocol and “-j” jump options to create your rules.</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level10.briefing_hard = "Hi,\n\n    I want you to update the firewall such that outgoing TCP packets to to the port 50 are dropped\n\n   \n\nB,"
				var ans10_1 = new Packet("139.130.4.5", "123.123.123.123", "", "50", "tcp", ["DROP"], "OUTPUT","");
				var ans10_2 = new Packet("139.130.4.5", "123.123.123.123", "", "80", "tcp", ["ACCEPT"], "OUTPUT","");
				level10.answer = [ans10_1,ans10_2];
				levels.push(level10);
				
				level11.briefing_easy = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets on port 15 is accepted\n\n   To add a rule to a chain use the “-A” or “--append” command followed by the chain name on which the rule should be added, and also followed by a range of options which define the rule. For example the option “-j” or “--jump” tells the rule what to do with a packet that is a match with the main section of the rule, by default iptables allows four targets: “ACCEPT”, “REJECT”, “DROP” and “LOG”. Options for the rule include “-p” or “--proto” which specifies the protocol and “--dport” specifies the destination port, these options are used to match corresponding packets i.e:\n\n   <font size=\"13\"><B> sudo iptables -A INPUT -j ACCEPT --dport 80 -p tcp</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level11.briefing_medium = "Hi,\n\n   I want you to update the firewall such that outgoing TCP packets on port 15 is accepted\n\n   <font size=\"13\"><B>Try to use the insert “-I” or append “-A” commands along with “--dport” destination port, “-p” protocol and “-j” jump options to create your rules.</B></font size=\"13\">\n\n   Remember that rules are applied by first match, try to think about your INPUT tables chosen default policy and if you need to add an extra rule at the end to specify what to do with unmatched packets.\n\nB,"
				level11.briefing_hard = "Hi,\n\n    I want you to update the firewall such that outgoing TCP packets on port 15 is accepted\n\n   \n\nB,"
				var ans11_1 = new Packet("139.130.4.5", "8.8.8.8", "", "15", "tcp", ["ACCEPT"], "OUTPUT","");
				var ans11_2 = new Packet("139.130.4.5", "8.8.8.8", "", "22", "tcp", ["DROP"], "OUTPUT","");
				var ans11_3 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "OUTPUT","");
				level11.answer = [ans11_1,ans11_2,ans11_3];
				levels.push(level11);
				
				var chainslvl12 = new Dictionary();
				var chainPolicylvl12 = new Dictionary();
				chainslvl12["INPUT"] = new Array();
				chainslvl12["OUTPUT"] = new Array();
				chainslvl12["FORWARD"] = new Array();
				chainPolicylvl12["INPUT"] = "DROP";
				chainPolicylvl12["FORWARD"] = "DROP";
				chainPolicylvl12["OUTPUT"] = "DROP";
				level12.briefing_easy = "Hi,\n\n    There has been word of a malicious attacker at the IP of <font size=\"13\"><B>9.9.9.9</B></font size=\"13\">\n\n  Update the firewall to pre-emptively protect us against this by rejecting all packets from that IP. Use “-s” or “--source” as an option to specify the IP address that a rule pertains to.\n\n<font size=\"13\"><B>sudo iptables -A INPUT -s 9.9.9.9</B></font size=\"13\">\n\nB,";
				level12.briefing_medium = "Hi,\n\n    There has been word of a malicious attacker at the IP of <font size=\"13\"><B>9.9.9.9</B></font size=\"13\">\n\n  Update the firewall to pre-emptively protect us against this by rejecting all packets from that IP. Use “-s” or “--source” as an option to specify the IP address that a rule pertains to.\n\nB,";
				level12.briefing_hard = "Hi,\n\n    There has been word of a malicious attacker at the IP of <font size=\"13\"><B>9.9.9.9</B></font size=\"13\">\n\n  Update the firewall to pre-emptively protect us against this by rejecting all packets from that IP.\n\nB,";
				chainslvl12["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80", "", "","80"))
				chainslvl12["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:455","","","455"))
				chainslvl12["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","","443"))
				chainslvl12["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp spt:80", "", "80",""))
				chainslvl12["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp spt:455","","455",""))
				chainslvl12["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp spt:443","","443",""))
				var ans12_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans12_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans12_3 = new Packet("9.9.9.9", "8.8.8.8", "", "80", "tcp", ["REJECT"], "INPUT", "");
				var ans12_4 = new Packet("139.130.4.5", "8.8.8.8", "", "333", "tcp", ["DROP"], "INPUT", "");
				var ans12_5 = new Packet("9.9.9.9", "8.8.8.8", "", "22", "tcp", ["REJECT"], "INPUT", "");
				var ans12_6 = new Packet("9.9.9.9", "8.8.8.8", "", "", "udp", ["REJECT"], "INPUT", "");
				level12.chains = chainslvl12
				level12.chainsPolicy = chainPolicylvl12
				level12.answer = [ans12_1,ans12_2,ans12_3,ans12_4,ans12_5,ans12_6];
				levels.push(level12);
				
				level13.briefing_easy = "Hi,\n\n   There is an effective new ransomware going around, for extra security incase any of our computers get infected, i'd like you to drop connetions back to the C&C center so that the RSA encryption keys are not sent and files will not be encrypted.\n\n   The current known IP for the C&C center is <font size=\"13\"><B>216.3.3.3</B></font size=\"13\">.\n\n   Remember that the randsomware will be is sending packets from inside the network so you need to drop the connection from the OUTPUT chain. <font size=\"13\"><B>Use “-d” or “--destination” to specify a destination IP address in a rule specification:</B></font size=\"13\"><font size=\"13\"><B>\n\n   sudo iptables -A OUTPUT -j DROP -d 216.3.3.3</B></font size=\"13\">\n\nB,";
				level13.briefing_medium = "Hi,\n\n   There is an effective new ransomware going around, for extra security incase any of our computers get infected, i'd like you to drop connetions back to the C&C center so that the RSA encryption keys are not sent and files will not be encrypted.\n\n   The current known IP for the C&C center is <font size=\"13\"><B>216.3.3.3</B></font size=\"13\">.\n\n   Remember that the randsomware will be is sending packets from inside the network so you need to drop the connection from the OUTPUT chain. <font size=\"13\"><B>Use “-d” or “--destination” to specify a destination IP address in a rule specification:</B></font size=\"13\">\n\nB,";
				level13.briefing_hard = "Hi,\n\n   There is an effective new ransomware going around, for extra security incase any of our computers get infected, i'd like you to drop connetions back to the C&C center so that the RSA encryption keys are not sent and files will not be encrypted.\n\n   The current known IP for the C&C center is <font size=\"13\"><B>216.3.3.3</B></font size=\"13\">.\n\n\n\nB,";
				var ans13_1 = new Packet("8.8.8.8", "126.3.3.3", "", "", "", ["DROP"], "OUTPUT","");
				var ans13_2 = new Packet("8.8.8.8", "139.11.11.11", "80", "", "tcp", ["ACCEPT"], "OUTPUT", "");
				level13.answer = [ans13_1,ans13_2];
				levels.push(level13);
				
				level14.briefing_easy = "Hi,\n\n   One of our engineers needed to use SSH from home and has attempted to modify the firewall to allow this.\n\n   He seems to have caused a bit of a mess, clean up and add the appropriate rules to allow SSH. I dont want everyone working from home so make sure only his home IP of <font size=\"13\"><B>139.12.12.12</B></font size=\"13\"> has access.\n\n  Use “-D” or “--delete” to delete a firewall rule and to allow incoming SSH connection you need to open port 22.\n\n    Use “--dport” and “--sport” to specify the port specification for the input and output rules remembering to also specify the TCP protocol with “-p”:\n\n   sudo iptables -A INPUT -p x --dport x -s x.x.x.x -j x\n\n   sudo iptables -A OUTPUT -p x --sport x -s x.x.x.x -j x\n\nB,";
				level14.briefing_medium = "Hi,\n\n   One of our engineers needed to use SSH from home and has attempted to modify the firewall to allow this.\n\n   He seems to have caused a bit of a mess, clean up and add the appropriate rules to allow SSH. I dont want everyone working from home so make sure only his home IP of <font size=\"13\"><B>139.12.12.12</B></font size=\"13\"> has access.\n\n  Use “-D” or “--delete” to delete a firewall rule and to allow incoming SSH connection you need to open port 22.\n\nB,";
				level14.briefing_hard = "Hi,\n\n   One of our engineers needed to use SSH from home and has attempted to modify the firewall to allow this.\n\n   He seems to have caused a bit of a mess, clean up and add the appropriate rules to allow SSH. I dont want everyone working from home so make sure only his home IP of <font size=\"13\"><B>139.12.12.12</B></font size=\"13\"> has access.\n\nB,";
				var chainslvl14 = new Dictionary();
				var chainPolicylvl14 = new Dictionary();
				chainslvl14["INPUT"] = new Array();
				chainslvl14["OUTPUT"] = new Array();
				chainslvl14["FORWARD"] = new Array();
				chainPolicylvl14["INPUT"] = "ACCEPT";
				chainPolicylvl14["FORWARD"] = "DROP";
				chainPolicylvl14["OUTPUT"] = "ACCEPT";
				chainslvl14["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80","","80",""))
				chainslvl14["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","443",""))
				chainslvl14["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:455","","443",""))
				chainslvl14["INPUT"].push(new Rule("DROP", "all", "", "anywhere", "anywhere", "", "", "","22"))
				chainslvl14["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:ssh","","22",""))
				chainslvl14["INPUT"].push(new Rule("ACCEPT", "tcp", "", "139.122.5.5", "8.8.8.8", " tcp dpt:ssh","","22",""))
				chainslvl14["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:ssh","","22",""))
				chainslvl14["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "139.122.5.5", "8.8.8.8", " tcp dpt:ssh","","22",""))
				chainslvl14["FORWARD"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:ssh","","22",""))
				chainslvl14["FORWARD"].push(new Rule("ACCEPT", "tcp", "", "139.122.5.5", "8.8.8.8", " tcp dpt:ssh","","22",""))
				chainslvl14["FORWARD"].push(new Rule("ACCEPT", "tcp", "", "139.122.5.5", "139.122.5.5", " tcp dpt:ssh","","22",""))
				chainslvl14["FORWARD"].push(new Rule("ACCEPT", "tcp", "", "8.8.8.8", "8.8.8.8", " tcp dpt:ssh","","22",""))
				var ans14_1 = new Packet("131.30.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans14_2 = new Packet("133.20.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans14_3 = new Packet("131.1.2.1", "8.8.8.8", "", "455", "tcp", ["ACCEPT"], "INPUT", "");
				var ans14_4 = new Packet("131.1.2.1", "8.8.8.8", "", "22", "tcp", ["ACCEPT"], "INPUT", "");
				var ans14_5 = new Packet("139.130.4.5", "8.8.8.8", "", "133", "tcp", ["DROP"], "INPUT", "");
				level14.answer = [ans14_1, ans14_2, ans14_3, ans14_4, ans14_5];
				level14.chains = chainslvl14;
				level14.chainsPolicy = chainPolicylvl14;
				levels.push(level14);
				
				var chainslvl15 = new Dictionary();
				var chainPolicylvl15 = new Dictionary();
				chainslvl15["INPUT"] = new Array();
				chainslvl15["OUTPUT"] = new Array();
				chainslvl15["FORWARD"] = new Array();
				chainPolicylvl15["INPUT"] = "DROP";
				chainPolicylvl15["FORWARD"] = "DROP";
				chainPolicylvl15["OUTPUT"] = "DROP";
				level15.briefing_easy = "Hi,\n\n    There has been word of a malicious attacker at the IP of <font size=\"13\"><B>111.111.111.111</B></font size=\"13\">\n\n  Update the firewall to pre-emptively protect us against this by rejecting all packets from that IP. Use “-s” or “--source” as an option to specify the IP address that a rule pertains to.\n\n<font size=\"13\"><B>sudo iptables -A INPUT -s 9.9.9.9</B></font size=\"13\">\n\nB,";
				level15.briefing_medium = "Hi,\n\n    There has been word of a malicious attacker at the IP of <font size=\"13\"><B>111.111.111.111</B></font size=\"13\">\n\n  Update the firewall to pre-emptively protect us against this by rejecting all packets from that IP. Use “-s” or “--source” as an option to specify the IP address that a rule pertains to.\n\nB,";
				level15.briefing_hard = "Hi,\n\n    There has been word of a malicious attacker at the IP of <font size=\"13\"><B>111.111.111.111</B></font size=\"13\">\n\n  Update the firewall to pre-emptively protect us against this by rejecting all packets from that IP.\n\nB,";
				chainslvl15["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:80", "", "","80"))
				chainslvl15["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:455","","","455"))
				chainslvl15["INPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:443","","","443"))
				chainslvl15["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp spt:80", "", "80",""))
				chainslvl15["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp spt:455","","455",""))
				chainslvl15["OUTPUT"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp spt:443","","443",""))
				var ans15_1 = new Packet("139.130.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT","");
				var ans15_2 = new Packet("139.130.4.5", "8.8.8.8", "", "443", "tcp", ["ACCEPT"], "INPUT", "");
				var ans15_3 = new Packet("111.111.111.111", "8.8.8.8", "", "80", "tcp", ["REJECT"], "INPUT", "");
				var ans15_4 = new Packet("139.130.4.5", "8.8.8.8", "", "333", "tcp", ["DROP"], "INPUT", "");
				var ans15_5 = new Packet("111.111.111.111", "8.8.8.8", "", "22", "tcp", ["REJECT"], "INPUT", "");
				var ans15_6 = new Packet("111.111.111.111", "8.8.8.8", "", "", "udp", ["REJECT"], "INPUT", "");
				level15.chains = chainslvl15
				level15.chainsPolicy = chainPolicylvl15
				level15.answer = [ans15_1,ans15_2,ans15_3,ans15_4,ans15_5,ans15_6];
				levels.push(level15);
				
				var chainslvl16 = new Dictionary();
				var chainPolicylvl16 = new Dictionary();
				chainslvl16["INPUT"] = new Array();
				chainslvl16["OUTPUT"] = new Array();
				chainslvl16["FORWARD"] = new Array();
				chainPolicylvl16["INPUT"] = "DROP";
				chainPolicylvl16["FORWARD"] = "DROP";
				chainPolicylvl16["OUTPUT"] = "DROP";
				level16.briefing_easy = "Hi,\n\n   I've noticed we dont allow loopback interface connections in our firewall. The loopback interface is used for network connections to itself for example: ping localhost.\n\n   Use interface specification options “-i” and -o” on the input and output chains to allow connections on the interface “lo”:\n\n<font size=\"13\"><B>sudo iptables -A INPUT -i lo -j ACCEPT</B></font size=\"13\">\n\nB,";
				level16.briefing_medium = "Hi,\n\n   I've noticed we dont allow loopback interface connections in our firewall.\n\n   Use interface specification options “-i” and -o” on the input and output chains to allow connections on the interface “lo”.\n\nB,";
				level16.briefing_hard = "Hi,\n\n   I've noticed we dont allow loopback interface connections in our firewall.\n\n   Use interface specification options to allow connections on the interface “lo”.\n\nB,";
				var ans16_1 = new Packet("131.30.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT", "lo");
				var ans16_2 = new Packet("131.30.4.5", "8.8.8.8", "", "80", "tcp", ["DROP"], "INPUT", "nolo");
				level16.answer = [ans16_1, ans16_2];
				level16.chains = chainslvl16
				level16.chainsPolicy = chainPolicylvl16
				levels.push(level16);
				
				var chainslvl17 = new Dictionary();
				var chainPolicylvl17 = new Dictionary();
				chainslvl17["INPUT"] = new Array();
				chainslvl17["OUTPUT"] = new Array();
				chainslvl17["FORWARD"] = new Array();
				chainPolicylvl17["INPUT"] = "DROP";
				chainPolicylvl17["FORWARD"] = "DROP";
				chainPolicylvl17["OUTPUT"] = "DROP";
				level17.briefing_easy = "Hi,\n\n   I additionally want you to accept incomming connections on the interface \"boss\".\n\n   Use interface specification options “-i” and -o” on the input and output chains to allow connections on the interface “boss”:\n\n<font size=\"13\"><B>sudo iptables -A INPUT -i boss -j ACCEPT</B></font size=\"13\">\n\nB,";
				level17.briefing_medium = "Hi,\n\n   I additionally want you to accept incomming connections on the interface \"boss\"\n\n   Use interface specification options “-i” and -o” on the input and output chains to allow connections on the interface “boss”.\n\nB,";
				level17.briefing_hard = "Hi,\n\n   I additionally want you to accept incomming connections on the interface \"boss\"\n\n   Use interface specification options to allow connections on the interface “boss”.\n\nB,";
				var ans17_1 = new Packet("131.30.4.5", "8.8.8.8", "", "80", "tcp", ["ACCEPT"], "INPUT", "boss");
				var ans17_2 = new Packet("131.30.4.5", "8.8.8.8", "", "80", "tcp", ["DROP"], "INPUT", "noboss");
				level17.answer = [ans17_1, ans17_2];
				level17.chains = chainslvl17
				level17.chainsPolicy = chainPolicylvl17
				levels.push(level17);
				
				var chainslvl18 = new Dictionary();
				var chainPolicylvl18 = new Dictionary();
				chainslvl18["INPUT"] = new Array();
				chainslvl18["OUTPUT"] = new Array();
				chainslvl18["FORWARD"] = new Array();
				chainPolicylvl18["INPUT"] = "DROP";
				chainPolicylvl18["FORWARD"] = "DROP";
				chainPolicylvl18["OUTPUT"] = "DROP";
				level18.chains = chainslvl18
				level18.chainsPolicy = chainPolicylvl18
				level18.briefing_easy = "Hi,\n\n   On the firewall server we now have one ethernet card connected to the external <font size=\"13\"><B>(eth0)</B></font size=\"13\">, and another ethernet card connected to the internal servers <font size=\"13\"><B>(eth1)</B></font size=\"13\">.\n\n   Use the FORWARD chain to allow internal network talk to external network using the interface specification options “-i” and -o”.\n\n   <font size=\"13\"><B> sudo iptables –A FORWARD -i eth1 -o eth0 –j ACCEPT</B></font size=\"13\">\n\nB,";
				level18.briefing_medium = "Hi,\n\n   On the firewall server we now have one ethernet card connected to the external <font size=\"13\"><B>(eth0)</B></font size=\"13\">, and another ethernet card connected to the internal servers <font size=\"13\"><B>(eth1)</B></font size=\"13\">.\n\n   Use the FORWARD chain to allow internal network talk to external network using the interface specification options “-i” and -o”.\n\nB,";
				level18.briefing_hard = "Hi,\n\n   On the firewall server we now have one ethernet card connected to the external <font size=\"13\"><B>(eth0)</B></font size=\"13\">, and another ethernet card connected to the internal servers <font size=\"13\"><B>(eth1)</B></font size=\"13\">.\n\n   Use the FORWARD chain to allow internal network talk to external network using the interface specification options.\n\nB,";
				var ans18_1 = new Packet("", "", "", "", "", ["ACCEPT"], "FORWARD", "eth0", "eth1");
				var ans18_2 = new Packet("", "", "", "", "", ["DROP"], "FORWARD", "eth3","eth4");
				level18.answer = [ans18_1,ans18_2];
				levels.push(level18);
				
				var chainslvl19 = new Dictionary();
				var chainPolicylvl19 = new Dictionary();
				chainslvl19["INPUT"] = new Array();
				chainslvl19["OUTPUT"] = new Array();
				chainslvl19["FORWARD"] = new Array();
				chainPolicylvl19["INPUT"] = "DROP";
				chainPolicylvl19["FORWARD"] = "DROP";
				chainPolicylvl19["OUTPUT"] = "DROP";
				level19.chains = chainslvl19
				level19.chainsPolicy = chainPolicylvl19
				level19.briefing_easy = "Hi,\n\n   The staff are getting a little tired of typing out full IP addresses when visiting websites, we need you to allow DNS connections.\n\n   Remember to specify the rule for the external interface <font size=\"13\"><B>(eth0)</B></font size=\"13\">, that dns connections need to be accepted for both UDP and TCP protocols, the <font size=\"13\"><B>outgoing destination port</B></font size=\"13\"> for DNS packets is <font size=\"13\"><B>53</B></font size=\"13\"> and the <font size=\"13\"><B>incoming source port</B></font size=\"13\"> for DNS packets should be <font size=\"13\"><B>53</B></font size=\"13\">\n\nB,";
				level19.briefing_medium = "Hi,\n\n   The staff are getting a little tired of typing out full IP addresses when visiting websites, we need you to allow DNS connections.\n\n   Remember to specify the rule for the external interface <font size=\"13\"><B>(eth0)</B></font size=\"13\">, that dns connections need to be accepted for both UDP and TCP protocols, the <font size=\"13\"><B>outgoing destination port</B></font size=\"13\"> for DNS packets is <font size=\"13\"><B>53</B></font size=\"13\"> and the <font size=\"13\"><B>incoming source port</B></font size=\"13\"> for DNS packets should be <font size=\"13\"><B>53</B></font size=\"13\">.\n\nB,";
				level19.briefing_hard = "Hi,\n\n   The staff are getting a little tired of typing out full IP addresses when visiting websites, we need you to allow DNS connections.\n\n   Remember to specify the rule for the external interface <font size=\"13\"><B>(eth0)</B></font size=\"13\">, that DNS connections need to be accepted for both UDP and TCP protocols , and the DNS port is 53. Think carefully which of source or destination ports need to be specified for the output and input rules.\n\nB,";
				var ans19_1 = new Packet("", "", "", "53", "udp", ["ACCEPT"], "OUTPUT", "", "eth0");
				var ans19_2 = new Packet("", "", "", "53", "udp", ["ACCEPT"], "INPUT", "eth0", "");
				var ans19_3 = new Packet("", "", "", "53", "tcp", ["ACCEPT"], "OUTPUT", "", "eth0");
				var ans19_4 = new Packet("", "", "", "53", "tcp", ["ACCEPT"], "INPUT", "eth0", "");
				var ans19_5 = new Packet("", "", "", "54", "tcp", ["DROP"], "OUTPUT", "", "");
				var ans19_6 = new Packet("", "", "", "54", "tcp", ["DROP"], "INPUT", "", "");
				var ans19_7 = new Packet("", "", "", "54", "udp", ["DROP"], "OUTPUT", "", "");
				var ans19_8 = new Packet("", "", "", "54", "udp", ["DROP"], "INPUT", "","");
				level19.answer = [ans19_1,ans19_2,ans19_3,ans19_4,ans19_5,ans19_6,ans19_7,ans19_8];
				levels.push(level19);
				
				var chainslvl20 = new Dictionary();
				var chainPolicylvl20 = new Dictionary();
				chainslvl20["INPUT"] = new Array();
				chainslvl20["OUTPUT"] = new Array();
				chainslvl20["FORWARD"] = new Array();
				chainPolicylvl20["INPUT"] = "DROP";
				chainPolicylvl20["FORWARD"] = "DROP";
				chainPolicylvl20["OUTPUT"] = "DROP";
				level20.chains = chainslvl20
				level20.chainsPolicy = chainPolicylvl20
				level20.briefing_easy = "Hi,\n\n   I've recenetly read an article about stateless vs stateful firewalls and feel we should re-implement our firewall in a stateful way as they can be better at identifying unauthorized and forged communications.\n\n   Iptables supports four states for packets: “NEW”,”ESTABLISHED”,”RELATED” and “INVALID”.\n\n   As a start I'd like you to allow established and related incoming connections.\n\n   <font size=\"20\"><B>To specify state you need to include the conntrack module by using “-m conntrack” which allows you to use the “--ctstate” option:</B></font size=\"13\">\n\n   <font size=\"13\"><B>sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT</B></font size=\"13\">\n\nB,";
				level20.briefing_medium = "Hi,\n\n   I've recenetly read an article about stateless vs stateful firewalls and feel we should re-implement our firewall in a stateful way as they can be better at identifying unauthorized and forged communications.\n\n   Iptables supports four states for packets: “NEW”,”ESTABLISHED”,”RELATED” and “INVALID”.\n\n   As a start I'd like you to allow established and related incoming connections.\n\n   <font size=\"13\"><B>To specify state you need to include the conntrack module by using “-m conntrack” which allows you to use the “--ctstate” option where arguments are seperated with a comma i.e: “--ctstate ESTABLISHED,RELATED”</B></font size=\"13\">\n\nB,";
				level20.briefing_hard = "Hi,\n\n   I've recenetly read an article about stateless vs stateful firewalls and feel we should re-implement our firewall in a stateful way as they can be better at identifying unauthorized and forged communications.\n\n   Iptables supports four states for packets: “NEW”,”ESTABLISHED”,”RELATED” and “INVALID”.\n\n   As a start I'd like you to allow established and related incoming connections.\n\n      <font size=\"13\"><B>To specify state you need to include the conntrack module which allows you to use the “--ctstate” option.</B></font size=\"13\">\n\nB,";
																					//new //related//established invalid
				var ans20_1 = new Packet("", "", "", "", "", ["ACCEPT"], "INPUT", "", "",false,true,false,false);
				var ans20_2 = new Packet("", "", "", "", "", ["ACCEPT"], "INPUT", "", "", false, false, true, false);
				var ans20_3 = new Packet("", "", "", "", "", ["DROP"], "INPUT", "", "", false, false, false, true);
				var ans20_4 = new Packet("", "", "", "", "", ["DROP"], "INPUT", "", "", true, false, false, false);
				level20.answer = [ans20_1,ans20_2,ans20_3,ans20_4];
				levels.push(level20);
				
				
				var chainslvl21 = new Dictionary();
				var chainPolicylvl21 = new Dictionary();
				chainslvl21["INPUT"] = new Array();
				chainslvl21["OUTPUT"] = new Array();
				chainslvl21["FORWARD"] = new Array();
				chainPolicylvl21["INPUT"] = "DROP";
				chainPolicylvl21["FORWARD"] = "DROP";
				chainPolicylvl21["OUTPUT"] = "DROP";
				level21.chains = chainslvl21
				level21.chainsPolicy = chainPolicylvl21
				level21.briefing_easy = "Hi,\n\n   Next thing I'd like you to work on for the stateful firewall is to allow established outgoing connections and to reject invalid incoming packets.\n\n   <font size=\"13\"><B>To specify state you need to include the conntrack module which allows you to use the “--ctstate” option.</B></font size=\"13\">\n\nB,";
				level21.briefing_medium = "Hi,\n\n   Next thing I'd like you to work on for the stateful firewall is to allow established outgoing connections and to reject invalid incoming packets.\n\nB,";
				level21.briefing_hard = "Hi,\n\n   Next thing I'd like you to work on for the stateful firewall is to allow established outgoing connections and to reject invalid incoming packets.\n\nB,";
				var ans21_1 = new Packet("", "", "", "", "", ["ACCEPT"], "OUTPUT", "", "", false, false, true, false);
				var ans21_2 = new Packet("", "", "", "", "", ["DROP"], "OUTPUT", "", "", false, true, false, false);
				var ans21_3 = new Packet("", "", "", "", "", ["DROP"], "OUTPUT", "", "", true, false, false, false);
				var ans21_4 = new Packet("", "", "", "", "", ["REJECT"], "INPUT", "", "", false, false, false, true);
				level21.answer = [ans21_1,ans21_2,ans21_3,ans21_4];
				levels.push(level21);
				
				var chainslvl22 = new Dictionary();
				var chainPolicylvl22 = new Dictionary();
				chainslvl22["INPUT"] = new Array();
				chainslvl22["OUTPUT"] = new Array();
				chainslvl22["FORWARD"] = new Array();
				chainPolicylvl22["INPUT"] = "DROP";
				chainPolicylvl22["FORWARD"] = "DROP";
				chainPolicylvl22["OUTPUT"] = "DROP";
				level22.chains = chainslvl22
				level22.chainsPolicy = chainPolicylvl22
				level22.briefing_easy = "Hi,\n\n   Given the four states for packets: “NEW”,”ESTABLISHED”,”RELATED” and “INVALID” devise a set of rules to allow incoming HTTP (port 80) connections and incoming HTTPS (port 443) connections.\n\n   Dont consider interface options for now.\n\nB,";
				level22.briefing_medium = "Hi,\n\n   Given the four states for packets: “NEW”,”ESTABLISHED”,”RELATED” and “INVALID” devise a set of rules to allow incoming HTTP (port 80) connections and incoming HTTPS (port 443) connections.\n\n   Dont consider interface options for now.\n\nB,";
				level22.briefing_hard = "Hi,\n\n   Given the four states for packets: “NEW”,”ESTABLISHED”,”RELATED” and “INVALID” devise a set of rules to allow incoming HTTP (port 80) connections and incoming HTTPS (port 443) connections.\n\n   Dont consider interface options for now.\n\nB,";
				//(src:String, dst:String, sport:String, dport:String, proto:String, ans:Array,table:String,iface:String="",oface:String="",NEW:Boolean=false,RELATED:Boolean=false,ESTABLISHED:Boolean=false,INVALID:Boolean=false) 
				var ans22_1 = new Packet("", "", "", "80", "tcp", ["ACCEPT"], "INPUT", "", "", true, false, false, false);	
				var ans22_2 = new Packet("", "", "", "80", "tcp", ["ACCEPT"], "INPUT", "", "", false, false, true, false);
				var ans22_3 = new Packet("", "", "", "80", "tcp", ["DROP"], "INPUT", "", "", false, false, false, true);
				var ans22_4 = new Packet("", "", "", "443", "tcp", ["ACCEPT"], "INPUT", "", "", true, false, false, false);	
				var ans22_5 = new Packet("", "", "", "443", "tcp", ["ACCEPT"], "INPUT", "", "", false, false, true, false);
				var ans22_6 = new Packet("", "", "", "443", "tcp", ["DROP"], "INPUT", "", "", false, false, false, true);
				var ans22_7 = new Packet("", "", "", "44", "tcp", ["DROP"], "INPUT", "", "", true, false, false, false);
				var ans22_8 = new Packet("", "", "80", "", "tcp", ["DROP"], "OUTPUT", "", "", true, false, false, false);	
				var ans22_9 = new Packet("", "", "80", "", "tcp", ["ACCEPT"], "OUTPUT", "", "", false, false, true, false);
				var ans22_10 = new Packet("", "", "80", "", "tcp", ["DROP"], "OUTPUT", "", "", false, false, false, true);
				var ans22_11 = new Packet("", "", "443", "", "tcp", ["DROP"], "OUTPUT", "", "", true, false, false, false);	
				var ans22_12 = new Packet("", "", "443", "", "tcp", ["ACCEPT"], "OUTPUT", "", "", false, false, true, false);
				var ans22_13 = new Packet("", "", "443", "", "tcp", ["DROP"], "OUTPUT", "", "", false, false, false, true);
				var ans22_14 = new Packet("", "", "44", "", "tcp", ["DROP"], "OUTPUT", "", "", true, false, false, false);
				level22.answer = [ans22_1,ans22_2,ans22_3,ans22_4,ans22_5,ans22_6,ans22_7,ans22_8,ans22_9,ans22_10,ans22_11,ans22_12,ans22_13,ans22_14];
				levels.push(level2);
				
				level23.briefing_easy = "Hi,\n\n   As our network becomes more complex it becomes more prudent to manage all the various connections in more than the three default chains.\n\n   Create a new chain called “SSH” using the “-N” command and route all incoming traffic on port 22 to this new chain using the new chain name as the target.\n\n   Make the new chains default policy REJECT.\n\n   <font size=\"13\"><B>sudo iptables -N SSH</B></font size=\"13\">\n\nB,";
				level23.briefing_medium = "Hi,\n\n   As our network becomes more complex it becomes more prudent to manage all the various connections in more than the three default chains.\n\n   Create a new chain called “SSH” using the “-N” command and route all incoming traffic on port 22 to this new chain using the new chain name as the target.\n\n   Make the new chains default policy REJECT.\n\nB,";
				level23.briefing_hard = "Hi,\n\n   As our network becomes more complex it becomes more prudent to manage all the various connections in more than the three default chains.\n\n   Create a new chain called “SSH” using the “-N” command and route all incoming traffic on port 22 to this new chain using the new chain name as the target.\n\n   Make the new chains default policy REJECT.\n\nB,";
				var ans23_1 = new Packet("131.1.2.1", "8.8.8.8", "", "22", "tcp", ["SSH"], "INPUT", "");
				var ans23_2 = new Packet("131.1.2.1", "8.8.8.8", "", "22", "tcp", ["REJECT"], "SSH", "");
				level23.answer = [ans23_1,ans23_2];
				levels.push(level23);
				
				var chainslvl24 = new Dictionary();
				var chainPolicylvl24 = new Dictionary();
				chainslvl24["INPUT"] = new Array();
				chainslvl24["OUTPUT"] = new Array();
				chainslvl24["FORWARD"] = new Array();
				chainPolicylvl24["INPUT"] = "DROP";
				chainPolicylvl24["FORWARD"] = "DROP";
				chainPolicylvl24["OUTPUT"] = "DROP";
				level24.chains = chainslvl24
				level24.chainsPolicy = chainPolicylvl24
				level24.briefing_easy = "Hi,\n\n   Further organisation of chains is in order, create a new chain called “ENGINEERS” which routes all at home traffic from our two engineers Mike and Jan whose IP addresses are <font size=\"13\"><B>19.19.19.19</B></font size=\"13\"> and <font size=\"13\"><B>20.20.20.20</B></font size=\"13\"> respectively.\n\n   On this new chain they need you to allow them SSH access and SMP access (port 445) but make sure to reject any other types of packets.\n\n   Recall the command for specifying source addresses: “-s”.\n\nB,";
				level24.briefing_medium = "Hi,\n\n   Further organisation of chains is in order, create a new chain called “ENGINEERS” which routes all at home traffic from our two engineers Mike and Jan whose IP addresses are <font size=\"13\"><B>19.19.19.19</B></font size=\"13\"> and <font size=\"13\"><B>20.20.20.20</B></font size=\"13\"> respectively.\n\n   On this new chain they need you to allow them SSH access and SMP access (port 445) but make sure to reject any other types of packets.\n\nB,";
				level24.briefing_hard = "Hi,\n\n   Further organisation of chains is in order, create a new chain called “ENGINEERS” which routes all at home traffic from our two engineers Mike and Jan whose IP addresses are <font size=\"13\"><B>19.19.19.19</B></font size=\"13\"> and <font size=\"13\"><B>20.20.20.20</B></font size=\"13\"> respectively.\n\n   On this new chain they need you to allow them SSH access and SMP access (port 445) but make sure to reject any other types of packets.\n\nB,";
				var ans24_1 = new Packet("19.19.19.19", "8.8.8.8", "", "", "", ["ENGINEERS"], "INPUT", "");
				var ans24_2 = new Packet("20.20.20.20", "8.8.8.8", "", "", "", ["ENGINEERS"], "INPUT", "");
				var ans24_3 = new Packet("21.21.21.21", "8.8.8.8", "", "", "", ["DROP"], "INPUT", "");
				var ans24_4 = new Packet("19.19.19.19", "8.8.8.8", "", "22", "", ["ACCEPT"], "ENGINEERS", "");
				var ans24_5 = new Packet("20.20.20.20", "8.8.8.8", "", "445", "", ["ACCEPT"], "ENGINEERS", "");
				var ans24_6 = new Packet("19.19.19.19", "8.8.8.8", "", "80", "", ["REJECT"], "ENGINEERS", "");
				level24.answer = [ans24_1,ans24_2,ans24_3,ans24_4,ans24_5,ans24_6];
				levels.push(level24);
				
				var chainslvl25 = new Dictionary();
				var chainPolicylvl25 = new Dictionary();
				chainslvl25["INPUT"] = new Array();
				chainslvl25["OUTPUT"] = new Array();
				chainslvl25["FORWARD"] = new Array();
				chainPolicylvl25["INPUT"] = "DROP";
				chainPolicylvl25["FORWARD"] = "DROP";
				chainPolicylvl25["OUTPUT"] = "DROP";
				level25.chains = chainslvl25
				level25.chainsPolicy = chainPolicylvl25
				level25.briefing_easy = "Hi,\n\n   Further organisation of chains is in order, create a new chain called “SALES” which routes all at home traffic from our sales manager whose IP address is <font size=\"13\"><B>25.25.25.25</B></font size=\"13\"> \n\n   On this new chain they need you to allow them full access.\n\nB,";
				level25.briefing_medium = "Hi,\n\n   Further organisation of chains is in order, create a new chain called “SALES” which routes all at home traffic from our sales manager whose IP address is <font size=\"13\"><B>25.25.25.25</B></font size=\"13\"> \n\n   On this new chain they need you to allow them full access.\n\nB,";
				level25.briefing_hard = "Hi,\n\n   Further organisation of chains is in order, create a new chain called “SALES” which routes all at home traffic from our sales manager whose IP address is <font size=\"13\"><B>25.25.25.25</B></font size=\"13\">\n\n   On this new chain they need you to allow them full access.\n\nB,";
				var ans25_1 = new Packet("25.25.25.25", "8.8.8.8", "", "", "", ["SALES"], "INPUT", "");
				var ans25_2 = new Packet("21.21.21.21", "8.8.8.8", "", "", "", ["DROP"], "INPUT", "");
				var ans25_3 = new Packet("25.25.25.25", "8.8.8.8", "", "22", "", ["ACCEPT"], "SALES", "");
				level25.answer = [ans25_1,ans25_2,ans25_3];
				levels.push(level25);
				/*
				var chainslvl19 = new Dictionary();
				var chainPolicylvl19 = new Dictionary();
				chainslvl19["INPUT"] = new Array();
				chainslvl19["OUTPUT"] = new Array();
				chainslvl19["FORWARD"] = new Array();
				chainslvl19["ENGINEERS"] = new Array();
				chainPolicylvl19["INPUT"] = "DROP";
				chainPolicylvl19["FORWARD"] = "DROP";
				chainPolicylvl19["OUTPUT"] = "DROP";
				chainPolicylvl19["ENGINEERS"] = "REJECT";
				chainslvl19["INPUT"].push(new Rule("ENGINEERS", "", "", "19.19.19.19", "anywhere", "", "", "", ""))
				chainslvl19["INPUT"].push(new Rule("ENGINEERS", "", "", "20.20.20.20", "anywhere", "", "", "",""))
				chainslvl19["ENGINEERS"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:22", "", "", "22"))
				chainslvl19["ENGINEERS"].push(new Rule("ACCEPT", "tcp", "", "anywhere", "anywhere", " tcp dpt:445", "", "","445"))
				level19.chains = chainslvl19
				level19.chainsPolicy = chainPolicylvl19
				level19.briefing_easy = "Hi,\n\n   I just took a look at the new engineers chain you added, the name looks a bit long and messy, shorten it to “ENG” please.\n\nB,";
				level19.briefing_medium = "Hi,\n\n   I just took a look at the new engineers chain you added, the name looks a bit long and messy, shorten it to “ENG” please using the “-E” command.\n\nB,";
				level19.briefing_hard = "Hi,\n\n   I just took a look at the new engineers chain you added, the name looks a bit long and messy, shorten it to “ENG” please using the “-E” command.\n\n   <font size=\"13\"><B>sudo iptables –E ENGINEERS ENG</B></font size=\"13\">\n\nB,";
				var ans19_1 = new Packet("19.19.19.19", "8.8.8.8", "", "", "", ["ENG"], "INPUT", "");
				var ans19_2 = new Packet("20.20.20.20", "8.8.8.8", "", "", "", ["ENG"], "INPUT", "");
				var ans19_3 = new Packet("21.21.21.21", "8.8.8.8", "", "", "", ["DROP"], "INPUT", "");
				var ans19_4 = new Packet("19.19.19.19", "8.8.8.8", "", "22", "tcp", ["ACCEPT"], "ENG", "");
				var ans19_5 = new Packet("20.20.20.20", "8.8.8.8", "", "445", "tcp", ["ACCEPT"], "ENG", "");
				var ans19_6 = new Packet("19.19.19.19", "8.8.8.8", "", "80", "tcp", ["REJECT"], "ENG", "");
				level19.answer = [ans19_1,ans19_2,ans19_3,ans19_4,ans19_5,ans19_6];
				levels.push(level19);*/
				

		}
	}
	
}

class Packet {
	
	public var source:String;
	public var destination:String;
	public var sport:String;
	public var dport:String;
	public var protocol:String;
	public var table:String
	public var answer:Array;
	public var iface:String;
	public var oface:String;
	
	public var NEW:Boolean;
	public var RELATED:Boolean;
	public var ESTABLISHED:Boolean;
	public var INVALID:Boolean;
	
	public function Packet(src:String, dst:String, sport:String, dport:String, proto:String, ans:Array,table:String,iface:String="",oface:String="",NEW:Boolean=false,RELATED:Boolean=false,ESTABLISHED:Boolean=false,INVALID:Boolean=false) 
	{
		this.source = src;
		this.destination = dst;
		this.sport = sport;
		this.dport = dport;
		this.protocol = proto;
		this.answer = ans;
		this.table = table;
		this.iface = iface;
		this.oface = oface;
		this.NEW = NEW;
		this.RELATED = RELATED;
		this.ESTABLISHED = ESTABLISHED;
		this.INVALID = INVALID;
	}
}

class Rule {
	
	public var target:String;
	public var prot:String;
	public var opt:String;
	public var source:String;
	public var destination:String;
	public var options:String;
	public var iface:String;
	public var sport:String;
	public var dport:String;
	public var oface:String;
	
	public var NEW:Boolean;
	public var RELATED:Boolean;
	public var ESTABLISHED:Boolean;
	public var INVALID:Boolean;
	
	public function clone():Rule {
		var c:Rule = new Rule(this.target,this.prot,this.opt,this.source,this.destination,this.options,this.iface,this.sport,this.dport)
		return c;
		
	}
	
	
	public function Rule(target:String, prot:String, opt:String, source:String, destination:String, options:String, iface:String, sport:String,dport:String,oface:String="",NEW:Boolean=false,RELATED:Boolean=false,ESTABLISHED:Boolean=false,INVALID:Boolean=false) 
	{
		this.target = target;
		this.prot = prot;
		this.opt = opt;
		this.source = source;
		this.destination = destination;
		this.options = options;
		this.iface = iface;
		this.sport = sport;
		this.dport = dport;
		this.oface = oface;
		this.NEW = NEW;
		this.RELATED = RELATED;
		this.ESTABLISHED = ESTABLISHED;
		this.INVALID = INVALID;
		
	}
	public function toRuleString():String {
		var s:String = target
		var tab = ""
		if (s == "DROP") {
			s += "  "
		} else if (s == "LOG") {
			s += "  "
		} else if (s == "") {
			s += "  "
		}
		s+= "\t"
		if (source == "anywhere") {
			tab = "                "
		} else if (source.length > 6) {
			tab = "                "
		} else if (source.length > 10) {
			tab = "                "
		} else if (source.length > 14) {
			tab = "                "
		}
		var rule:String = s + prot + " -- " + source + tab + destination + "                  " + options + "\n";
		return rule;
	}
	
	public function outcome(packet:Packet):String {
		if ((packet.protocol == prot || prot == "all") && (packet.source == source || source == "anywhere") && (packet.destination == destination || destination == "anywhere") && (!(packet.oface) || packet.oface == oface) && (!(packet.iface) || packet.iface == iface) && (!(sport) || (sport == packet.sport)) && (!(dport) || dport == packet.dport) && (!(options.indexOf("ctstate")>=0) || ((!packet.NEW || NEW) && (!packet.RELATED || RELATED) && (!packet.ESTABLISHED || ESTABLISHED) && (!packet.INVALID || INVALID)))) {
			if (target) {
				return target;
			} else {
				return "UNMATCHED";	//Is actually matched just has no target in the specified rule, so treat as if no action/ummatched
			}
		} else {
			return "UNMATCHED";
		}
	}
}