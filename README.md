
Hubot The Verge Live
============
[![gittip](https://img.shields.io/gittip/Ale46.svg)](https://www.gratipay.com/Ale46/)

Follow live events covered by TheVerge through your Hubot.

Dependencies
-------

Add to your `package.json` the following packages under the dependencies section

`"request": "2.40.0"`

`"wait": "0.1.0"`


Install
-------

- Add `src/theverge-live.coffee` to your Hubot's script directory


Commands
--------

`hubot start live <theverge url>` - Start posting news from the live event

`hubot stop live` - Stop following the event


License
-------

Hubot Dogeme is licensed under the [GPL][gpl] license.



[gpl]: http://www.gnu.org/copyleft/gpl.html

Issues
-------

- Some html tag can be possibly not cleared correctly
- Tweet post are not managed (part of html will be posted)
