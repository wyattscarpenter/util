// ==UserScript==
// @name         Discord Kill Time
// @namespace    https://github.com/wyattscarpenter/util
// @version      9
// @author       wyattscarpenter
// @description  Discord text formatting don't be annoying challenge
// @match        *://discordapp.com/*
// @match        *://discord.com/*
// @grant        none
// ==/UserScript==

//I am indebted to jcunews's Discord Keyword Notification userscript https://greasyfork.org/en/scripts/373445-discord-keyword-notification for figuring out the init function which lets my script run on discord.
//It seems to be quite finicky and I wouldn't have gotten it on my own.
//His userscript says it's GNU AGPLv3 so maybe that implies this one is also? I don't really know.

//TODO: NOCHECKIN: this is an attempt to remove the crashiness of this script (I don't think it liked it when you changed classes or removed items) but now the script randomly works or doesn't, and I'm not really sure why.
//Also, I haven't tested this setup in cozy theme
let colonated_headers = new Set();

function killTime(){ //should work for both compact and cozy.
  document.querySelectorAll('[class^="latin24CompactTimeStamp"]').forEach(element => element.style.userSelect = "none"); //compact mode timestamp
  document.querySelectorAll('[class^="timestamp"]').forEach(element => element.style.userSelect = "none") //cozy mode timestamp
  document.querySelectorAll('[class^="copyOnlyText"]').forEach(element => element.style.userSelect = "none"); //clan tag, at least in compact mode (haven't checked the other one)
  //Sometimes there's a leading space before some usernames when you copy them? I think this is due to the alt text on avatars in compact display (which for some reason is " "). Still not sure why it only happens sometimes but at least I can fix it. // This doesn't seem to prevent the problem.
  document.querySelectorAll('[class^="avatar"]').forEach(element => element.style.userSelect = "none");
  document.querySelectorAll('[class^="separator"]').forEach(element => element.style.userSelect = "none") //since separator location differs between cozy and compact, it's best just to not use it.
  //Since I still want a copyable colon in cozy mode, we add one:
  document.querySelectorAll('[class^="headerText"]').forEach(element => {
      element.lastChild.remove();
      if (!colonated_headers.has(element)) {
          element.firstChild.append(":"); colonated_headers.add(element);
      }
  });
}

var observer = false, observing = false;
function init() {
  setInterval(function(e) {
    if (!observing && document.querySelector('[class^="separator"]')) { //We delay running the function until this type of element is loaded, so as to avoid bogging down the page-load performance with Observing every change to the DOM before we need to.
        colonated_headers = new Set();
        observing = true;
      if (!observer) {
          observer = new MutationObserver(killTime);
      }
      observer.observe(document.querySelector('html'), {childList: true, subtree: true}); //I don't really understand why we need to bind to html, but it seems to work that way and no other.
    }
  }, 500);
}
init();
