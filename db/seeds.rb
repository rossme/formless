# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# frozen_string_literal: true
User.destroy_all
puts 'Destroyed all users. Re-seeding database...'

User.create!(email: 'user@formless.ai', password: '123123123')
puts 'Created user with email: user@formless.ai'

Prompt.destroy_all
puts 'Destroyed all prompts. Re-seeding database...'

Client.destroy_all
puts 'Destroyed all clients. Re-seeding database...'

Prompt.create(
  [
    {
      input: 'Create a new client called James Smith, 09/02/1999, German, 0898989898',
      output: { 'id' => 'chatcmpl-7zDbpmkC5xRabdtDRDUkSjjZW0ee4',
                'object' => 'chat.completion',
                'created' => 1694824677,
                'model' => 'ft:gpt-3.5-turbo-0613:personal::7ypZAKh8',
                'choices' =>
                  [{ 'index' => 0,
                     'message' =>
                       { 'role' => 'assistant',
                         'content' =>
                           { 'first_name' => 'James',
                             'middle_name' => '',
                             'last_name' => 'Smith',
                             'phone_number' => '0898989898',
                             'date_of_birth' => '09/02/1999',
                             'nationality' => 'MEX',
                             'national_number' => '' } },
                     'finish_reason' => 'stop' }],
                'usage' => { 'prompt_tokens' => '[FILTERED]', 'completion_tokens' => '[FILTERED]', 'total_tokens' => '[FILTERED]' } },
      user: User.last,
      created_at: 2.days.ago,
      updated_at: 2.days.ago,
      actioned: true,
      action: 'Client created',
      actionable_type: 'Client',
      actionable_id: 1
    },
    {
      input: "What is the name of my last client?\n",
      output: { 'id' => 'chatcmpl-7zDcFWkNW4EiQ4NhQGIg5hBFuSAcI',
                'object' => 'chat.completion',
                'created' => 1694824703,
                'model' => 'ft:gpt-3.5-turbo-0613:personal::7ypZAKh8',
                'choices' => [{ 'index' => 0, 'message' => { 'role' => 'assistant', 'content' => 'The name of your last client is [GET_LAST_CLIENT_NAME].' }, 'finish_reason' => 'stop' }],
                'usage' => { 'prompt_tokens' => '[FILTERED]', 'completion_tokens' => '[FILTERED]', 'total_tokens' => '[FILTERED]' } },
      user: User.last,
      created_at: 2.days.ago,
      updated_at: 2.days.ago,
      actioned: true,
      action: 'The name of your last client is James Smith, id: 2.',
      actionable_type: nil,
      actionable_id: nil
    },
    {
      input: 'Create Jane Maria Doe, 0798989898, born on 12/11/2001, email address jane_maria_doe@fake_email.com, national number JB123123A, British citizen, female.',
      output: { 'id' => 'chatcmpl-80csqonR4qQoM0kwgUuwcqLsDx07S',
                'object' => 'chat.completion',
                'created' => 1695160160,
                'model' => 'ft:gpt-3.5-turbo-0613:personal::7ypZAKh8',
                'choices' =>
                  [{ 'index' => 0,
                     'message' =>
                       { 'role' => 'assistant',
                         'content' =>
                           { 'first_name' => 'Jane',
                             'middle_name' => 'Maria',
                             'last_name' => 'Doe',
                             'phone_number' => '0798989898',
                             'date_of_birth' => '12/11/2001',
                             'nationality' => 'GBR',
                             'national_number' => 'JB123123A',
                             'gender' => 'female',
                             'email' => 'jane_maria_doe@fake_email.com' } },
                     'finish_reason' => 'stop' }],
                'usage' => { 'prompt_tokens' => '[FILTERED]', 'completion_tokens' => '[FILTERED]', 'total_tokens' => '[FILTERED]' } },
      user: User.last,
      created_at: 2.days.ago,
      updated_at: 2.days.ago,
      actioned: true,
      action: 'Client created',
      actionable_type: 'Client',
      actionable_id: 2
    },
    {
      input: 'How many clients do I have?',
      output: { 'id' => 'chatcmpl-7ztiG6lrNdKHhTPpUbvb9ouGybY03',
                'object' => 'chat.completion',
                'created' => 1694986524,
                'model' => 'ft:gpt-3.5-turbo-0613:personal::7ypZAKh8',
                'choices' => [{ 'index' => 0, 'message' => { 'role' => 'assistant', 'content' => 'Let me check for you. You currently have [GET_CLIENTS_COUNT] clients.' }, 'finish_reason' => 'stop' }],
                'usage' => { 'prompt_tokens' => '[FILTERED]', 'completion_tokens' => '[FILTERED]', 'total_tokens' => '[FILTERED]' } },
      user: User.last,
      created_at: 1.day.ago,
      updated_at: 1.day.ago,
      actioned: true,
      action: 'Let me check for you. You currently have 2 clients.',
      actionable_type: nil,
      actionable_id: nil
    }
  ]
)

Client.create(
  [
    {
      id: 1,
      first_name: 'James',
      middle_name: '',
      last_name: 'Smith',
      phone_number: '0898989898',
      date_of_birth: '09/02/1999',
      email: nil,
      national_number: '',
      nationality: 'MEX',
      user: User.last,
      created_at: 2.days.ago,
      updated_at: 2.days.ago,
      gender: nil
    },
    {
      id: 2,
      first_name: 'Jane',
      middle_name: 'Maria',
      last_name: 'Doe',
      phone_number: '0798989898',
      date_of_birth: '12/11/2001',
      email: 'jane_maria_doe@fake_email.com',
      national_number: 'JB123123A',
      nationality: 'GBR',
      user: User.last,
      created_at: 2.days.ago,
      updated_at: 2.days.ago,
      gender: 'female'
    }
  ]
)

puts "Created #{Prompt.count} new prompts"
puts "Created #{Client.count} new clients"
puts "Created #{User.count} new users"
puts 'Database re-seeded!'
