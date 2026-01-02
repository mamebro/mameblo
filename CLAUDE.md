# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## Project Overview

まめぶろ (mameblo) is a private blog application for "brothers" (family members) built with Ruby on Rails.

## Tech Stack

- Ruby 3.4.7
- Rails 8.1.1
- PostgreSQL
- Sprockets (asset pipeline)
- HAML templates
- RSpec for testing
- jQuery
- infinite-scroll v3

## Development Commands

```bash
# Install dependencies
bundle install
npm install

# Run server
bundle exec rails server -p 3002

# Run tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/path/to/spec.rb
```

## Project Structure

- `app/models/` - Entry, Brother, Bean, Hashtag, Relationship models
- `app/controllers/` - Standard Rails controllers
- `app/views/` - HAML templates
- `app/helpers/` - View helpers including `sanitize_markdown`, `convert_bro`
- `app/assets/` - Sprockets-managed assets (JS, CSS, images)
- `spec/` - RSpec tests

## Key Features

- **Entries**: Blog posts with Markdown support (Redcarpet)
- **Brothers**: User accounts (family members)
- **Beans**: Like/reaction system
- **Hashtags**: Tag system for entries
- **Stamps**: Custom emoji-like images (`:brocheers:`, `:brook:`, etc.)

## Coding Guidelines

1. **Language**: Code comments and git commits in English, UI text in Japanese
2. **Testing**: Always run `bundle exec rspec` before committing
3. **Markdown**: Use `sanitize_markdown` helper for user-generated Markdown content
4. **Security**: Never bypass sanitization for user content
5. **Templates**: Use HAML for views
6. **Styling**: Use SCSS in `app/assets/stylesheets/`

## Common Patterns

### Markdown Rendering
```ruby
# In views, always use sanitize_markdown for Markdown content
= sanitize_markdown convert_bro(entry.content_as_markdown)
```

### Creating Tests
```ruby
# spec/helpers/application_helper_spec.rb
describe ApplicationHelper, type: :helper do
  it 'test description' do
    expect(helper_method(input)).to eq expected_output
  end
end
```

## Notes

- The application uses `http_basic_authenticate_with` for admin authentication
- InfiniteScroll is used for paginated entry lists
- Kaminari handles pagination
