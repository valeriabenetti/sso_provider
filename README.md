# SSO Provider with OAuth2 Implementation
### Overview
This project aims to create a Single Sign-On (SSO) provider using OAuth2 protocol, allowing multiple applications to authenticate users with a single username and password. The project should include a Proof of Concept application (sso_consumer) to demonstrate integration with the SSO provider.

### Requirements
- Ruby on Rails 
- Devise gem for user authentication
- Doorkeeper gem for OAuth2 implementation

### Installation
1. Clone the repository to your local machine:

```bash
git clone https://github.com/your_username/sso_provider.git
```

2. Navigate to the project directory:

```bash
cd sso_provider
```

3. Install dependencies using Bundler:

```bash
bundle install
```

### Configuration
#### Devise Setup

1. Configure Devise for user authentication. Make sure to set up the User model with required attributes and validations.

2. Use Devise callbacks before_reset_password and after_reset_password in the User model to invalidate sessions on password change.


#### Doorkeeper Setup

1. Configure Doorkeeper in config/initializers/doorkeeper.rb to set up OAuth applications, token expiration, etc.

2. Implement OAuth2 endpoints in a separate controller for handling OAuth authentication flows like token issuance and revocation.


#### SSO Provider Logic

1. Create a Sessions controller to handle user login/logout sessions.

2. Implement OAuth2 endpoints in a separate controller to handle OAuth2 authentication flows.

3. Configure routes in config/routes.rb for Sessions and OAuth controllers and actions.

#### Testing

1. Write unit and integration tests using RSpec or Minitest.

2. Test OAuth2 authentication, session expiration on password change, and overall functionality of the SSO provider.

3. Test the Proof of Concept application (sso_consumer) to ensure integration with the SSO provider.

### Usage

1. Start the Rails server:

```bash
rails server
```

2. Access the SSO provider application in your web browser:

```arduino
http://localhost:3000
```

3. *TODO* Use the Proof of Concept application (sso_consumer) to test the SSO provider integration. 

### Current Status
- Devise Setup: Should be able to implement user authentication with Devise, including password reset callbacks.

- Doorkeeper Setup: Configured Doorkeeper for OAuth2 protocol?

- SSO Provider Logic: Implemented Sessions controller and OAuth controller for authentication flows.

- Testing: Partially implemented unit and integration tests. More testing is needed to correct current errors.

### Next Steps

1. Complete testing for OAuth2 authentication, session expiration, and overall functionality.

2. Improve error handling and security measures.

3. Enhance the Proof of Concept application (sso_consumer) to demonstrate various scenarios.

4. Refactor code for better readability and maintainability.

#### Notes
This is my first time using OAuth, I am not 100% certain I am going in the the right path or if I should scrap and restart. 

Trying my hand on this in Elixir: https://github.com/valeriabenetti/hello