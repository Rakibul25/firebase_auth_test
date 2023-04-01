# Introduction
This project is mainly focused on login and signup that uses Firebase and Firestore to provide users with a seamless and secure experience. Users can easily create an account, sign in using different authentication methods.
The app supports manual signup, allowing users to create an account using their name, email, and password. Users can also choose to sign up with their Facebook or Google account, making the process faster and more convenient.

In addition, the app has a built-in feature to validate email and password inputs. This means that the app will check whether the email is a valid email format and whether the password meets the minimum requirements (such as minimum length, uppercase letters, or special characters). This ensures that users create strong and secure passwords and helps to prevent unauthorized access to their accounts.

Also this app adjust the UI layout when the keyboard is opened to ensure that no UI element is hidden behind the keyboard. This was achieved by dynamically adjusting the layout, providing a smooth and accessible user experience.

Overall, it provides a simple and effective way for users to create accounts and securely access key features using Firebase and Firestore.

[Video Preview](https://www.linkedin.com/posts/rakibul-islam-9078b1187_flutter-firebase-flutterdeveloper-activity-7047860195951071232-dUFb?utm_source=share&utm_medium=member_desktop)

# About Tools & Technology
Developed using Flutter with state management handled by Provider. Firebase was used for the backend, with Firebase Authentication for user authentication and Firestore for data storage and retrieval. The app followed the MVC architecture to ensure maintainability and extendibility.

# LoginPage
It provides a default login page that includes multiple login options to cater to the needs of all users. Users can either login manually using their email and password, or login with their Facebook or Google account.
The password field has a hide/show option, allowing users to choose whether they want to hide or show the characters they are typing. This provides an added layer of security and helps users to avoid typos while entering their password.
When a user enters their email and password on the login page, the app will first check if the user exists in the database. If the user is already registered, the app will redirect the user to the home page. Similarly, when a user logs in with their Facebook or Google account, the app will authenticate the user and redirect them to the home page. If a user wants to create a new account, they can do so by clicking the "create new account" option. This will redirect them to the signup page.

<table>
  <tr>
     <td>Login</td>
     <td>Adjusting UI after keyboard popup</td>
     <td>Password Visibility</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/login_normal.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/login_keyboard.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/login_visible.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
 <table>
  <tr>
     <td>Checking if account available</td>
     <td>Loading account</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/checking.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/loggingin.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
# SignUp
It allows users to create an account manually with their name, email, and password with the help of firebase auth and firestore. The email field has validation rules to ensure that the email address entered is valid, while the password field has specific requirements, such as a minimum length of 8 characters and a maximum length of 14 characters, at least one lowercase letter, one uppercase letter, one number, and one special character. If the email and password is valid then it will show password and email are valid.
In addition to manual signup, users can also sign up using their Google or Facebook accounts. This process is facilitated by Firebase Authentication, which handles the signup process securely and efficiently.
Once a user has successfully signed up, they will be redirected to the home page of the app. All user data is stored in Firestore, which provides real-time data synchronization and efficient data retrieval.

<table>
  <tr>
     <td>SignUp</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/signup_normal.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
 <table>
  <tr>
     <td>Invalid Email</td>
     <td>Valid Email</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/email_invalid.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/email_valid.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
  <table>
  <tr>
     <td>Invalid Password</td>
     <td>Valid Password</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/invalid_pass.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/valid_pass.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
   <table>
  <tr>
     <td>Facebook SignUp</td>
     <td>Google SignUp</td>
     <td>Signing Up and redirecting to home</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/facebook_prompt.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/google_login.jpg" width="200" height="440"></td>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/facebook_loading.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
<table>
  <tr>
     <td>Home</td>
  </tr>
  <tr>
    <td><img src="https://github.com/Rakibul25/firebase_auth_test/blob/main/ss/home.jpg" width="200" height="440"></td>
  </tr>
 </table>
 
 # Developed by
[Rakibul Islam](https://github.com/Rakibul25)
