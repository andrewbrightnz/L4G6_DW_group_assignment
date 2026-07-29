PROJECT INTRO:


VIRTUAL ENVIRONMENT:
Our virtual environment is called: l4g6_env
Set this up using the requirements.txt file


LISTINGS.CSV COLUMN DEFINITIONS
From https://docs.google.com/spreadsheets/d/1iWCNJcSutYqpULSQHlNyGInUvHg2BoUGoNRIGa6Szc4/edit?usp=sharing
id

- name
Airbnb's unique identifier for the listing

- host_id
Airbnb's unique identifier for the host/user (the host may have many listings)

- host_name
The Airbnb page for the host

- neighbourhood_group
The neighbourhood group as geocoded using the latitude and longitude against neighborhoods as defined by open or public digital shapefiles.

- neighbourhood
Undefined by airbnb, but seems to show the local area/suburb the listing is in

- latitude
Uses the World Geodetic System (WGS84) projection for latitude and longitude.

- longitude
Uses the World Geodetic System (WGS84) projection for latitude and longitude.

- room_type
[Entire home/apt|Private room|Shared room|Hotel]

All homes are grouped into the following three room types:

-- Entire place
-- Private room
-- Shared room

-- Entire place
Entire places are best if you're seeking a home away from home. With an entire place, you'll have the whole space to yourself. This usually includes a bedroom, a bathroom, a kitchen, and a separate, dedicated entrance. Hosts should note in the description if they'll be on the property or not (ex: "Host occupies first floor of the home"), and provide further details on the listing.

-- Private rooms
Private rooms are great for when you prefer a little privacy, and still value a local connection. When you book a private room, you'll have your own private room for sleeping and may share some spaces with others. You might need to walk through indoor spaces that another host or guest may occupy to get to your room.

-- Shared rooms
Shared rooms are for when you don't mind sharing a space with others. When you book a shared room, you'll be sleeping in a space that is shared with others and share the entire space with other people. Shared rooms are popular among flexible travelers looking for new friends and budget-friendly stays.
price

- minimum_nights
minimum number of night stay for the listing (calendar rules may be different)

- number_of_reviews
The number of reviews the listing has

- last_review
The date of the last/newest review

- reviews_per_month
The average number of reviews per month the listing has over the lifetime of the listing.

- calculated_host_listings_count
The number of listings the host has in the current scrape, in the city/region geography.

- availability_365
The availability of the listing x days in the future as determined by the calendar. Note a listing may not be available because it has been booked by a guest or blocked by the host.

- number_of_reviews_ltm
The number of reviews the listing has (in the last 12 months)

- license
The licence/permit/registration number



AI USE:
Acknowledge AI use here:

Andrew
- Got help setting up the virtual environment and gitignore file