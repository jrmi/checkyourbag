Check Your Bag
==============

Checkyourbag is a web application to check the content of your bag before going on journey.
Now, you just can tap on an item to check it and re-tap to unchek it.
This application should remains simple over the time.

This is a [Firefox OS](https://www.mozilla.org/en-US/firefox/os/) 
application published on the [marketplace](https://marketplace.firefox.com/app/checkyourbag/).

Checked items are now saved and you can create mutiple bag template and edit bag content.

TODO
=======
* Filter by category (like "children", "mountains", "more than 4 days", ...)
* More translation
* Remote/cached data list with cache manifest
* Add more data


Installation
============

This project requires nodejs, bower and grunt
in order to be built.

1.) Install Node
Linux Ubuntu 12.04:
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo  apt-get install nodejs

Windows:
download msi installer from web site http://nodejs.org/

2.) Install bower
Under linux run as root
Under Windows make sure portable git is in the search path

npm install -g bower
npm install -g grunt-cli


3.) clone project

4.) build
 cd project
npm install # installs dependencies from package.json (build utilities)
bower install # installs dependencies from bower.json (required libraries)
grunt serve # run test server
grunt build # build for a web server
grunt release # creates zip file for Firefox OS
