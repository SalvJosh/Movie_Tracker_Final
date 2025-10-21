# User Flow Documentation

## 1. Landing on the Website

**Route:** `/`  
**View:** `home()` → `base.html`

When a user visits the site:

- If **not logged in**, they see the homepage with navigation links (e.g., Register, Login, Search).
- If **logged in**, they’re redirected to their **Profile** or **Watchlist** page.

---

## 2. User Registration Flow

**Route:** `/register`  
**Access:** Public (no login required)  
**Form:** `RegistrationForm`

### Steps

1. User clicks **Sign Up** or navigates to `/register`.
2. Form fields:
   - Username
   - Email
   - Password
   - Confirm Password
3. On submission:
   - Validates required fields and matching passwords.
   - Checks for existing username/email.
   - Hashes the password using **Bcrypt**.
   - Creates a new `User` record in the database.
   - Displays: `“Account created successfully! Please log in.”`
   - Redirects to `/login`.

### Validation Errors

- Duplicate username or email.
- Empty fields or mismatched passwords.

---

## 3. Login Flow

**Route:** `/login`  
**Access:** Public (no login required)  
**Form:** `LoginForm`

### Steps

1. User navigates to `/login`.
2. Form fields:
   - Username
   - Password
3. On submission:
   - App searches for the user in the database.
   - Verifies password using **Bcrypt**.
   - If correct:
     - Logs the user in via `login_user(user)`.
     - Displays: `“Login successful!”`
     - Redirects to `/` (or `/profile`).
   - If incorrect:
     - Displays: `“Login unsuccessful. Please check username and password.”`

---

## 4. Profile Page

**Route:** `/profile`  
**Access:** Requires authentication (`@login_required`)

Displays:

- User’s info (username, email, etc.)
- Links to **Search**, **Watchlist**, and **Logout**

Acts as a simple personal dashboard.

---

## 5. Search for Movies

**Route:** `/search`  
**Access:** Public (adding to watchlist requires login)  
**External API:** [OMDb API](https://www.omdbapi.com/)

### Steps

1. User enters a movie name in the search bar.
2. App sends a GET request to OMDb:
   https://www.omdbapi.com/?apikey={OMDB_API_KEY}&s={query}
3. The API returns a JSON response with titles, years, and posters.
4. The results are displayed in `search.html`.

### Notes

- Logged-in users see **Add to Watchlist** buttons.
- Guests can search but cannot save movies.
- If no results: message like “No movies found.”

---

## 6. Watchlist

**Route:** `/watchlist`  
**Access:** Authenticated users only

Displays all movies linked to the logged-in user:

- Poster image
- Title
- Year
- “Mark as Watched” button
- “Watched” label (if already marked)

### Routes

- `/watchlist` → List all movies for current user.
- `/watchlist/mark_watched/<movie_id>` → Mark a movie as watched.

### Logic

- Verifies the movie belongs to the current user.
- Updates `movie.watched = True`.
- Displays success message and redirects back to the watchlist.

---

## 7. Add to Watchlist

**Route:** `/add_to_watchlist`  
**Method:** POST  
**Access:** Authenticated users only

### Steps

1. User clicks “Add to Watchlist” on a search result.
2. Form posts `title`, `year`, and `poster`.
3. Flask creates a new `Movie` linked to `current_user.id`:

```python
movie = Movie(title=title, year=year, poster=poster, user_id=current_user.id)
db.session.add(movie)
db.session.commit()
4. Displays: “{Title} added to your watchlist!”
5. Redirects to /watchlist.
```

## 8. Logout

**Route:** `/logout`  
**Access:** Authenticated users only

### Steps

1. Executes `logout_user()`
2. Displays: "You have been logged out."
3. Redirects to `/login`
