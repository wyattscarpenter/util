// ==UserScript==
// @name         Discord Double Block
// @namespace    https://github.com/wyattscarpenter/util
// @version      1
// @author       wyattscarpenter
// @description  Removes "message blocked" message from blocked messages in discord.
// @match        *://discordapp.com/*
// @match        *://discord.com/*
// @grant        none
// ==/UserScript==

//I am indebted to jcunews's Discord Keyword Notification userscript https://greasyfork.org/en/scripts/373445-discord-keyword-notification for figuring out the init function which lets my script run on discord.
//It seems to be quite finicky and I wouldn't have gotten it on my own.
//His userscript says it's GNU AGPLv3 so maybe that implies this one is also? I don't really know.

function doubleBlock(){
  document.querySelectorAll('[class^="blockedMessageText"]').forEach(element => element.remove())
}

function tripleBlock(){
  document.querySelectorAll('[class^="blockedSystemMessage"]').forEach(element => element.remove())
}

var observer, observing, selector = '[class^="chat-"]'; //'[class^="scrollerInner-"]'; //this also works, as per https://greasyfork.org/en/scripts/373445-discord-keyword-notification/discussions/60844

function init() {
  var observerInit = {childList: true, subtree: true};
  setInterval(function(e) {
    if (!observing && (e = document.querySelector(selector))) {
      observing = true;
      if (!observer) {observer = new MutationObserver(doubleBlock)};
      observer.observe(e, observerInit);
    }

  }, 500);
}
init();
