# Introduction
This project is mainly focused on login and signup that uses Firebase and Firestore to provide users with a seamless and secure experience. With this app, users can easily create an account, sign in using different authentication methods, and access key features to achieve their goals.

The app supports manual signup, allowing users to create an account using their name, email, and password. Users can also choose to sign up with their Facebook or Google account, making the process faster and more convenient.

In addition, the app has a built-in feature to validate email and password inputs. This means that the app will check whether the email is a valid email format and whether the password meets the minimum requirements (such as minimum length, uppercase letters, or special characters). This ensures that users create strong and secure passwords and helps to prevent unauthorized access to their accounts.

Overall, it provides a simple and effective way for users to create accounts and securely access key features using Firebase and Firestore.

# Tools & Technology
Developed using Flutter with state management handled by Provider. Firebase was used for the backend, with Firebase Authentication for user authentication and Firestore for data storage and retrieval. The app followed the MVC architecture to ensure maintainability and extendibility.

# LoginPage
This project provides a default login page that includes multiple login options to cater to the needs of all users. Users can either login manually using their email and password, or login with their Facebook or Google account.
The password field has a hide/show option, allowing users to choose whether they want to hide or show the characters they are typing. This provides an added layer of security and helps users to avoid typos while entering their password.
When a user enters their email and password on the login page, the app will first check if the user exists in the database. If the user is already registered, the app will redirect the user to the home page. Similarly, when a user logs in with their Facebook or Google account, the app will authenticate the user and redirect them to the home page.
