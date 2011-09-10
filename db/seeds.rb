# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

RuleAction.create(:title => "edit")
RuleAction.create(:title => "show")
RuleAction.create(:title => "upload")

Markup.create(:title => "Markdown")
Markup.create(:title => "Textile")
Markup.create(:title => "RDoc")
Markup.create(:title => "Org-mode")
Markup.create(:title => "Creole")
Markup.create(:title => "MediaWiki")
Markup.create(:title => "Plain Text")
Markup.create(:title => "Uploaded File")
Markup.create(:title => "Alias")