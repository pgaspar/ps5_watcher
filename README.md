# Ps5Watcher

PS5 Watcher checks PlayStation 5 inventory in the stores defined in `stores.yml` and notifies you via [Pushover](https://pushover.net) if there are changes.

## Installation

For now, to use this code you need to clone the repository and add your own `.env` file, based on `.env.example`. This is where you set up your Pushover credentials so you can get notified on your phone.

After checking out the repo, run `bin/setup` to install dependencies.

## Usage

Start the watcher by running the `ps5_watcher` executable. This will query the stores every 5 minutes.

    $ bin/ps5_watcher

## Supporting other stores

I appreciate Pull Requests adding add other stores to [`stores.yml`](https://github.com/pgaspar/ps5_watcher/blob/main/stores.yml). Here's a quick description of the fields:

- `id`: A unique string identifying this store. I'm currently using this format: `<store_name>_<country>_<digital or standard PS5 edition>`
- `product_url`: The URL of the product listing you want the watcher to check
- `selector`: The CSS selector for finding the unavailable text
- `unavailable_text`: The text the code will look for inside the CSS `selector`

If the webpage supports jQuery you can try to see if your `selector` and `unavailable_text` works by running this on the page:

```javascript
jQuery(selector).first().text().includes(unavailable_text);
```

If the product is unavailable, this should return `true`.

Note: Please make sure you run `bin/validator` to verify that the `stores.yml` file looks as expected before opening a Pull Request.

## TODO

If other people use this code I'll probably work on these improvements:

- [ ] Allow store filtering from the command line
- [ ] Add other notifiers besides Pushover
- [ ] Possibly add a few extra fields to `stores.yml` like the country and digital/standard edition
- [ ] Release the code as a gem, still allowing configuration - like the pushover user keys, etc, the selected notifier, etc.
- [ ] Consider ways for regular users to define their own stores without needing to add them to this Github repo.

This code is mostly generic - you can use this to check availability of other products, not just PS5. It might be interesting to make this a generic product stock watcher.

## Development

Run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pgaspar/ps5_watcher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Ps5Watcher project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pgaspar/ps5_watcher/blob/main/CODE_OF_CONDUCT.md).
