*Ruby on Rails 6 with ReactJS front - Testing Action Cable with fancy drag and drop*

 Quickstart
====================

Git clone
---------
git clone https://github.com/antoineBernard/dnd-actioncable-rails6.git

RVM install
---------

* Bash : `curl -sSL https://get.rvm.io | bash -s stable --ruby`

Install ruby 2.7.0 (with RVM)
---------
	rvm list
	rvm install 2.7.0
	rvm use 2.7.0

Install Postgresql and start service (on MacOS)
---------
     brew install postgresql
     brew services start postgresql

Install Bundle
---------
	gem install bundler
	bundle install

Install Yarn
---------
	brew install yarn
	yarn install


Configure database.yml
---------
* Copy .database.yml.example dans database.yml (create a new file)
* In database.yml replace YOUR USERNAME et YOUR PASSWORD with postgres user with creation right.
  To see users in postgresql :
    - psql postgres
    - \du

Create database
---------
    rails db:create
    rails db:migrate

Run tests and linters
---------
    sh alltests

Run only linters (Rubocop and EsLint)
---------
    sh alllinters
