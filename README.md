# Formless

**Formless** is a PoC designed to streamline the client onboarding process, eliminating the need for extensive form filling. This solution leverages user prompts, a fine-tuned OpenAI model, and a Rails application to create client objects and manage user requests related to recently onboarded clients. [formless.onrender.com](https://formless.onrender.com)

## How it Works

### User Prompt

Users initiate the client onboarding process by providing a simple text prompt:

`"Please add a new client called Jane Doe, born 19-02-1989, British, national number is DE3131212, female, 07772772727, their email is jms@email.com"`

### AI Response and Variables

On receiving the user prompt, the fine-tuned AI model springs into action, generating a structured response. In the example provided above, let's say we're onboarding a client named Jane Doe. The AI response is structured as a hash with predefined keys:

- `first_name`
- `middle_name`
- `last_name`
- `date_of_birth`
- `email`
- `nationality`
- `national_number`
- `phone_number`
- `gender`

These keys are populated with data extracted from the original user prompt, forming the AI's response. The values are formatted in the Rails application, `date_of_birth` becomes `DD/MM/YYYY`, `nationality` becomes `GBR`, using ISO 3166-1 alpha-3.

### User Queries

Once the client data is processed and saved, users can inquire about it using natural language queries such as:

- `"What is the name of the last client I created?"`
- `"How many clients do I have?"`

For security and privacy reasons, the AI does not have direct access to the database. Instead, it responds with variable placeholders within the text response it generates, for example:

`"Let me check for you. You currently have [GET_CLIENTS_COUNT] clients."`

## Technical Overview

The Rails application interprets these queries and populates the placeholders with real data from the database. Various validation steps are in place throughout this process to ensure data accuracy and security.

### Middleware

- **OpenAiRateLimitable**: This middleware helps limit and manage OpenAI requests, preventing rate limits from being exceeded. It fetches user session information through Warden and keeps track of the number of user requests made within the last hour.

### Devise

A default fake user is assigned to the session, simplifying the application's use. It's important to note that this approach is recommended for the proof of concept phase.

### Ruby Gems

The Formless application relies on several Ruby gems to enhance its functionality:

- **Ruby-openai**: This gem serves as a client for the OpenAI fine-tuned model.
- **Kaminari**: It provides straightforward pagination capabilities.
- **Rspec**: Extensive testing is ensured using RSpec.
- **Factorybot-rails**: This gem facilitates testing by providing factories for generating test data.
- **Sidekiq**: Asynchronous workload handling is managed efficiently with Sidekiq.
- **Octokit**: It enables fetching the latest repository release tags from GitHub.
- **Devise**: This gem handles user sessions and authentication.

### TDD Testing

Test-Driven Development is an integral part of the development process. RSpec is used to ensure test coverage across various components, including controller and service object requests, concerns, and additional API/v1 endpoints.

### API v1 Serialization and Documentation

In addition to the standalone application, there are also some api/v1 endpoints where all user prompts can be requested and the api schema docuemtation can also be retrieved.

### Hosting

Formless is hosted on [formless.onrender.com](https://formless.onrender.com) and makes use of the following addons:

- `sidekiq-worker`: Manages background jobs.
- `sidekiq-redis`: Supports Sidekiq for asynchronous task processing.
- `PostgreSQL 15`: The application's database is powered by PostgreSQL 15.

---

*Please refer to this README for an in-depth understanding of Formless and its technical underpinnings.*
