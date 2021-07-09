// ==UserScript==
// @name         Discord Kill Time
// @namespace    https://github.com/wyattscarpenter/util
// @version      3
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
  //TODO: In compact on firefox, there is an unfortunate space between the username and the :, caused by a "whitespace only text node" in there...
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
