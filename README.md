Ruby Word Counter Gem
=========

Usage
-----

Include gem to your project
```ruby
gem 'word_counter'
```
```WordCounter::Base.from_text``` and ```WordCounter::Base.from_file``` returns instance of ```WordCounter::Base```, with attributes ```words``` and ```errors```.


There is two-way approach to usage:

#### Count words from file
```ruby
WordCounter::Base.from_file('path_to_your_file').words
```
#### Count words from text
```ruby
WordCounter::Base.from_text('insert text here').words
```
Count words on site
-----
Currently gem supports counting words on desired site. Be advised that this is experimental feature. If ```words == 0``` check ```errors``` attribute
#### Usage
```ruby
WordCounter::Url.from_url('insert url here').words
```
Supported formats
-----
- Microsoft Office OLE 2 and Office Open XML Formats (.doc, .docx, .xls, .xlsx, .ppt, .pptx)
- OpenOffice.org OpenDocument Formats (.odt, .ods, .odp)
- Apple iWorks Formats
- Rich Text Format (.rtf)
- Portable Document Format (.pdf)

For the complete list of supported formats, please visit the Apache Tika [Supported Document Formats page](http://tika.apache.org/1.13/formats.html).

Average time to count word
-----
- pdf file with 10138 words ≈6 sec.
- rtf file with 29790 words ≈5 sec.
- doc/docx file with 150972 words ≈4,5 sec
- txt file with 139860 words ≈1.7 sec

Testing
-----
Gem uses Rspec for testing and provides several test files:
```ruby
rspec spec
```

Dealing with problems
------------------------
All exceptions will fall to ```errors``` field

```ruby
word_counter = WordCounter::Base.from_text('')
word_counter.errors #=> {:text=>"Text is empty"}
```
Dependencies
------------------------

```ruby
gem 'yomu', git: 'git@github.com:zakrevitz/yomu.git', :branch => 'update-mime-type'
```
##### Java Runtime

WordCounter requires a working JRE for it to work.




Copyright © 2016 Shyshkov E., Netfix LLC, released under the MIT license
