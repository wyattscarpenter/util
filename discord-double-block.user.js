// ==UserScript==
// @name         Discord Double Block
// @namespace    https://github.com/wyattscarpenter/util
// @version      4
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

var observer = false, observing = false;
function init() {
  setInterval(function(e) {
    if (!observing && document.querySelector('[class^="separator"]')) { //We delay running the function until the scollerInner is loaded, so as to avoid bogging down the page-load performance with Observing every change to the DOM before we need to.
      observing = true;
      if (!observer) {
          observer = new MutationObserver(doubleBlock);
      }
      observer.observe(document.querySelector('html'), {childList: true, subtree: true}); //I don't really understand why we need to bind to html, but it seems to work that way and no other.
    }
  }, 500);
}
init();
