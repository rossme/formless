# spec/factories/clients.rb

FactoryBot.define do
  factory(:ai_training_file) do
    training_file { '123123123123123' }
    ai_model { 'gpt-3.5' }
    training_job do
      {
        'job' => 'ftjob-AF123AF123123',
        'messages' => {
          'system' => 'You are a helpful assistant'
        }
      }
    end
  end
end
