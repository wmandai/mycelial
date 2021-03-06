Mycelial: A Rails app for a portfolio-based social network. 
=========

Mycelial could be useful for a visual CV social network/portfolio social network. The user pages are linked together via a tagging system. There is a main feed and tag-specific feeds. Each user's posts are automatically related to similar posts via the sporeprint algorithm, which orders them based on degree of correlation (number of tag matches). Mycelial has a pinterest-style layout, nested comments, a like system, notifications, amazon s3 uploads and picture cropping, feeds, and much more. 

See the demo: [http://www.mycelial.com/](http://www.mycelial.com/) 

An example user profile page. Great for a visual CV/Portfolio.

![mycelial](https://github.com/damian-sowers/mycelial/raw/master/app/assets/images/landing_page/browser-landing.png)

### Features:

* Page caching with memcachier, dalli and redis
* Devise user management
* Uploads to s3 with carrierwave and fog
* Pinterest layout with the masonry plugin. Posts without pictures are given a nice random colored header. 
* Tags associated with each post. JQuery enabled tagging system with acts-as-taggable on gem. Tags can be given pictures on the backend so user pages look really nice with the tags. 
* Hot Feed, and individual category feeds for each tag (ordered by popularity)
* Nested Comments, and a JQuery overlay popup for adding new comments.
* Notification system for new likes and new comments. 
* Delayed jobs can be used with resque. (not currently running with the demo. But is already configured for use. I have some demo jobs in the workers folder for you to reference. A backend resque interface comes equipped too)
* Foreman is used to run the development server (just need to make your own .env file)
* Unicorn and postgres are used for production server environment
* Pry-remote gem is included for debugging. 

Note: It's been designed to run on Heroku. 

### License:

MIT