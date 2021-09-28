$(function () {
		var status = 'pause';
		$('#heartbeat').trigger(status);
		
		var debugMode = true;
		var increments = 50;
		var increment_count = 0;
		var vol = 0.2;
		var volActual = vol;
		var d_vol = -2.0 + vol + 2.0;
		var volFadeOutDecrement = vol/increments; //50
		var audioPlaying = false;
		var fadingAudio;
		var len = 0;
		Wait = (ms) => new Promise(resolve =>  setTimeout(resolve, ms));
		
		function postLoadCout (text) {
			if (debugMode) {
				$.post('http://bloodyscreen/cout', JSON.stringify({
					text: text
				}));
			}
		}
		
		var coutOnceBlackList = []
		function has (i) {
			var found = false;
			coutOnceBlackList.forEach((item, index) => { 
				if (item == i) {
					//postLoadCout('"' + i + '" is in the list...');
					found = true;
					return true;
				} 
			});
			
			if (found) {
				return true;
			}
			else {
				//postLoadCout('"' + i + '" is not in the list...');
				return false;
			}
		}
		
		function postLoadCoutOnce (text) {
			var success = false;
			if (debugMode) {
				if (!has(text)) {
					len = coutOnceBlackList.push(text);
					 success = true;
					//postLoadCout('string "' + text + '" pushed (' + len + ')' + ' ...');
					$.post('http://bloodyscreen/cout', JSON.stringify({
						text: text
					}));
				}
			}
			return success;
		}
		
		function resetCoutString (text) {
			var success = false;
			coutOnceBlackList.forEach((item, index) => {
				if (item == text) {
					coutOnceBlackList[index] = "";
					success = true;
				}
			});
			return success;
		}
		
		var interval = 0;
		function fadeOutAudio_interval () {
			++increment_count;
			if (d_vol == 0.0) {
				postLoadCoutOnce("function doing what it's supposed to... yay");
				status = 'pause';
				$('#heartbeat').trigger(status);
				fadingAudio = false;
				window.clearInterval(interval);
			}
			if ((d_vol - volFadeOutDecrement) <= 0.0) { 
				postLoadCoutOnce("landing at 0...");
				vol = 0.0;
				d_vol = -2.0 + vol + 2.0;
			}
			else {
				postLoadCoutOnce("simple arithmetic and if-condition actually works... amazing");
				vol = vol - volFadeOutDecrement;
				d_vol = -2.0 + vol + 2.0;
			}
			postLoadCout("volume: " + vol + " (" + increment_count + ")");
			document.getElementById("heartbeat").volume = vol; 
		}
		
		function fadeOutAudio () {
			fadingAudio = true;
			pass = true
			//postLoadCoutOnce("it actually entered the function block... wow");
		//	while (fadingAudio) {
			//	fadeOutAudio_interval ();
				// Wait(100);
			//}
			status = 'pause';
			$('#heartbeat').trigger(status);
		}
				
		 function keepAudioSync () {
			while (true) {
				 Wait(1000);
				postLoadCout("Current time: " + document.getElementById("heartbeat").currentTime);
			}
		}
		
		function play (state) {
			volActual = state;
			vol = volActual;
			document.getElementById("heartbeat").currentTime = 0;
			$("#heartbeat").prop("muted",false);
			document.getElementById("heartbeat").volume = volActual;
			status = 'play';
			//postLoadCout("playing")
			$('#heartbeat').trigger(status);
		}
		
		function updateVolume (state) {
			volActual = state;
			vol = state;
			document.getElementById("heartbeat").volume = vol; 
		}
		
		function updatePlaybackSpeed (state) {
			myaudio=document.getElementById("heartbeat");
			myaudio.playbackRate=state;	
		}
		
		function message (type, state) {
			if (type === "fadeOutAudio") fadeOutAudio();
			if (type === "play") play(state);
			if (type === "updateVolume") updateVolume(state);
			if (type === "updatePlaybackSpeed") updatePlaybackSpeed(state);
		}
		
		window.addEventListener('message', function (event) {
			var item = event.data;
			message(item.type, item.status);
		});
});
