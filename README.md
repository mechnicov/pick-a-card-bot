## Pick a Card bot

### Description

This is TelegramBot on Ruby. Language: Russian

This bot will shuffle a deck for you and give you as many cards as you ask.

### Running

1. Download repo to your local directory and type there

```
bundle
```

2. Create the bot at Telegram using [@botfather](https://telegram.me/botfather)

You need your bot's API Token like `285662358:KKLLERo_pXlJJ8lfkQ88pK6MlkfkLK3oPJRgH`.

3. In your `.env` file write

```
TELEGRAM_BOT_API_TOKEN = '285662358:KKLLERo_pXlJJ8lfkQ88pK6MlkfkLK3oPJRgH'
```

4. Now you can run app

```
ruby main.rb
```

### Localization

You can change messages text in `.env` file.


### Deploying on Heroku

Type before pushing

```
heroku buildpacks:set heroku/ruby
```

After pushing go to dashboard and switch on dynos.

### License

MIT – see `LICENSE`

### Contacts

Email me at

```
'dcdl-snotynu?fl`hk-bnl'.each_char.map(&:succ).join
```
