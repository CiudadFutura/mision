FactoryGirl.define do
  factory :admin do
    email 'admin@example.com'
    password '!QAZzaq1'
    confirmed_at Time.now
    type Usuario::ADMIN
    after(:create) { |user| user.confirm! }
  end

  factory :user, class: Usuario do
    email 'user@example.com'
    password '!QAZzaq1'
    confirmed_at Time.now
    type Usuario::USUARIO
    after(:create) { |user| user.confirm! }
  end

  factory :coordinador, class: Coordinador do
    nombre 'nombre_coordinador'
    apellido 'apellido_coordinador'
    email 'coordinador@example.com'
    password '!QAZzaq1'
    confirmed_at Time.now
    type Usuario::COORDINADOR
    after(:create) { |user| user.confirm! }
  end
end