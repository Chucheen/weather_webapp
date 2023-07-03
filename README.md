# Weather App

## Description

This is a Weather website application that connects to [OpenWeather](https://home.openweathermap.org/) via API and returns the weather information for the location coordinates or city name.
It handles success and error responses

## Setup

### Environment Variable

This project requires the use of the `OPEN_WEATHER_API_KEY` environment variable to access the OpenWeather API. Follow the instructions below to set it up:

1. Check your email for the shared `OPEN_WEATHER_API_KEY` value.
2. Open your project in a text editor.
3. Create a new file named `.env.local` in the root directory of your project if it doesn't already exist.
4. Open the `.env.template` file and copy its contents.
5. Paste the copied contents into the `.env.local` file.
6. Replace `<shared_openweather_api_key>` in `.env.local` with the actual value shared via email.

### Dependencies

This project relies on Ruby version 3.1.3 and Rails version 7.0.6. Ensure that you have them installed on your system before proceeding.

### Installation

To install the necessary dependencies, run the following command:

```shell
$ bundle install
```

### Running tests

This project uses RSpec for testing. To run the tests, follow the steps below:

Make sure you have all the necessary dependencies installed.
In your project's root directory, run the following command:
```shell
$ bundle exec rspec
```

### Using it
1. run `rails s` inside the cloned folder
2. Go to `localhost:3000`
3. Put a valid latitud and longitude values or a city name and click on `Get me the info!`
4. In case there's an error, a flash will tell you so at the top of the form
5. If everything is ok, you will see the weather primary information

### Considerations
This is a project that lacks of good UI because of the short time invested on it (also because i have 0 design skills xD). 

Also approach could've been better by using a database, a Form Object or some sort of proxy to handle the form state and because of that be more RESTful with `resource` routes.

I wanted to make a small approach that doesn't take a lot of time, not because is not worth it, but because of personal time and current responsibilities 