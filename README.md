# Seat Management System

This is a Ruby on Rails application developed with Ruby version 3.0.0, Rails version 7.0.4.3, and Redis version 7.0.11.

## Prerequisites

Make sure you have the following software installed on your development machine:

- Ruby 3.0.0: [Installation instructions](https://www.ruby-lang.org/en/documentation/installation/)
- Rails 7.0.4.3: [Installation instructions](https://guides.rubyonrails.org/getting_started.html#installing-rails)
- Redis 7.0.11: [Installation instructions](https://redis.io/topics/quickstart)

## Getting Started

1. Clone the repository:

```bash
git clone https://github.com/Minio10/Seat-Management-System.git
cd Seat-Management-System
```

2. Install dependencies:

```bash
bundle
```

3. Run migrations:

```bash
rails db:migrate
```

4. Load the database with the seeds:

```bash
rails db:seed
```

5. Start the rails server:

```bash
rails server
```

6. Open your web browser and navigate to http://localhost:3000 to see the application.

## Project Idea

The main idea behind this application was to create a seat management system that would provide real time information regarding seat availability. When a user visits the application, he can select the seats that are currently free, when he selects a given free seat, an ajax request is made to the server, then the server locks that seat and updates the database regarding the availability of the seat, after updating it, we use a websocket to broacast the updated seat to the others users, so that that seat is no longer available (the color changes to light-red for the other users) and grey to the current user. The same logic is applied when the current user decides to unselect one or more of his current selected seats. Then, there is a button to confirm the reservation of the selected seats, which will trigger another ajax request to the server and lock those seats accordingly, then the status of the seats is updated to reserved and we use another websocket to broacast that change to the other users.
