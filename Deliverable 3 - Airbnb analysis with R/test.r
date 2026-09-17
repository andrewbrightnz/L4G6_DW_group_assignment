print(here("Data", "test_rentals.db"))
print(file.exists(here("Data", "test_rentals.db")))

print(file.info(here("Data", "test_rentals.db"))$size)