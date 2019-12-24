## Wished Cities docker

### Features
- Docker Compose for managing the services.
- Makefile for better dev experience.

### Try it!
In your local:
- Install `docker`.
- Clone the project.
- Create a .env file for the database environment (you can use the `.env.example` as a reference).
- `make`. Build everything.
- Play around! Everything is in `localhost` + the ports that you have defined in `.env`.

### Useful commands
- `make shell-api`. Access the API container console.
- `make shell-app`. Access the app container console.
- `make prepare`. Run the database migrations and seeders.
- You can check the `Makefile` to check all the commands behind the scenes.