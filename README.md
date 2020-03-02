# csv_to_html

A gem to automate generation of HTML files from an ERB template and a CSV.

The advantage here is that your template can treat the CSV columns as
methods, abstracting implementation details.

## Installation

Clone this repository and run:

`$ rake install`

Or alternatively use something like [specific_install](https://github.com/rdp/specific_install).

## Usage

csv_to_html accepts the build command:

`$ csv_to_html build template.html.erb input.csv output_dir/`

Which will generate a HTML file for every row in `input.csv`, using
`template.html.erb` as the template, in the `output_dir/` directory.

Let's say you have the following template:

```erb
<h1><%= title %></h1>

<p><%= first_paragraph %></p>

<img src="<%= img_src %>">

<p><%= second_paragraph %></p>
```

Where some necessary HTML tags are excluded for simplicity.

And the following CSV:

```
title,first_paragraph,img_src,second_paragraph
Title,A paragragh,imgsite.com/myimage.png,Another paragraph
```

And you run the command above, you'll end up with the following HTML file
in your `output_dir/`:

```html
<h1>Title</h1>

<p>A paragraph</p>

<img src="imgsite.com/myimage.png">

<p>Another paragraph</p>
```


### Optional parameters

`build` accepts two optional parameters:
  - --delimiter (-d), sets CSV delimiter (`,` by default)
  - --filename-col (-c), sets a column to use as HTML filename (CSV row number
  otherwise)

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console` for
an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/tuneduc/csv_to_html).
