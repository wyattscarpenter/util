// ==UserScript==
// @name         Discord Triple Block
// @namespace    https://github.com/wyattscarpenter/util
// @version      5
// @author       wyattscarpenter
// @description  Removes "message blocked" message from blocked messages in discord, COMPLETELY.
// @match        *://discordapp.com/*
// @match        *://discord.com/*
// @grant        none
// ==/UserScript==

//I am indebted to https://github.com/Multarix/Discord-Hide-Blocked-Messages for figuring out how to do this.

const css = '[class^="blockedSystemMessage"] { display: none; }'
const style = document.createElement('style'); style.innerHTML = css;
document.body.appendChild(style);
