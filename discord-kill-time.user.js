// ==UserScript==
// @name         Discord Kill Time
// @namespace    https://github.com/wyattscarpenter/util
// @version      6
// @author       wyattscarpenter
// @description  Discord text formatting don't be annoying challenge
// @match        *://discordapp.com/*
// @match        *://discord.com/*
// @grant        none
// ==/UserScript==

//I am indebted to jcunews's Discord Keyword Notification userscript https://greasyfork.org/en/scripts/373445-discord-keyword-notification for figuring out the init function which lets my script run on discord.
//It seems to be quite finicky and I wouldn't have gotten it on my own.
//His userscript says it's GNU AGPLv3 so maybe that implies this one is also? I don't really know.

function killTime(){ //should work for both compact and cozy.
  document.querySelectorAll('[class^="latin24CompactTimeStamp"]').forEach(element => element.style.userSelect = "none") //compact mode timestamp
  document.querySelectorAll('[class^="timestamp"]').forEach(element => element.style.userSelect = "none") //cozy mode timestamp
  document.querySelectorAll('[class^="separator"]').forEach(element => element.remove()) //since separator location differs between cozy and compact, it's best just to not use it.
  //Since I still want a copyable colon in cozy mode, we add one:
  //(We also change the class as a lazy way of preventing an infinite colon-adding loop.)
  document.querySelectorAll('[class^="headerText"]').forEach(element => {element.append(": "); element.className = "colonatedHeaderText";})
}

var observer = false, observing = false;
function init() {
  setInterval(function(e) {
    if (!observing && document.querySelector('[class^="separator"]')) { //We delay running the function until this type of element is loaded, so as to avoid bogging down the page-load performance with Observing every change to the DOM before we need to.
      observing = true;
      if (!observer) {
          observer = new MutationObserver(killTime);
      }
      observer.observe(document.querySelector('html'), {childList: true, subtree: true}); //I don't really understand why we need to bind to html, but it seems to work that way and no other.
    }
  }, 500);
}
init();
