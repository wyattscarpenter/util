// ==UserScript==
// @name         Discord Kill Time
// @namespace    https://github.com/wyattscarpenter/util
// @version      1
// @author       wyattscarpenter
// @description  Discord text formatting don't be annoying challenge
// @match        *://discordapp.com/*
// @match        *://discord.com/*
// @grant        none
// ==/UserScript==

//I am indebted to jcunews's Discord Keyword Notification userscript https://greasyfork.org/en/scripts/373445-discord-keyword-notification for figuring out the init function which lets my script run on discord.
//It seems to be quite finicky and I wouldn't have gotten it on my own.
//His userscript says it's GNU AGPLv3 so maybe that implies this one is also? I don't really know.

function killTime(){ //should work for both compact and cozy. I forget what is for which.
  document.querySelectorAll('[class^="latin24CompactTimeStamp"]').forEach(element => element.remove())
  document.querySelectorAll('[class^="timestamp"]').forEach(element => element.replaceWith(": "))
  document.querySelectorAll('[class^="separator"]').forEach(element => element.replaceWith(": "))
}

var observer, observing, selector = '[class^="chat-"]'; //'[class^="scrollerInner-"]'; //this also works, as per https://greasyfork.org/en/scripts/373445-discord-keyword-notification/discussions/60844

function init() {
  setInterval(function(e) {
    if (!observing && (e = document.querySelector(selector))) {
      observing = true;
      if (!observer) {observer = new MutationObserver(killTime)};
      observer.observe(e, {childList: true, subtree: true});
    }

  }, 500);
}
init();
