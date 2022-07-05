# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_220_629_092_007) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'answers', force: :cascade do |t|
    t.string 'body'
    t.boolean 'best', default: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'question_id'
    t.bigint 'user_id'
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
  end

  create_table 'attachments', force: :cascade do |t|
    t.string 'file'
    t.bigint 'attachable_id'
    t.string 'attachable_type'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['attachable_id'], name: 'index_attachments_on_attachable_id'
    t.index ['attachable_type'], name: 'index_attachments_on_attachable_type'
  end

  create_table 'oauth_access_grants', force: :cascade do |t|
    t.bigint 'resource_owner_id', null: false
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.integer 'expires_in', null: false
    t.text 'redirect_uri', null: false
    t.datetime 'created_at', null: false
    t.datetime 'revoked_at'
    t.string 'scopes', default: '', null: false
    t.index ['application_id'], name: 'index_oauth_access_grants_on_application_id'
    t.index ['resource_owner_id'], name: 'index_oauth_access_grants_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_grants_on_token', unique: true
  end

  create_table 'oauth_access_tokens', force: :cascade do |t|
    t.bigint 'resource_owner_id'
    t.bigint 'application_id', null: false
    t.string 'token', null: false
    t.string 'refresh_token'
    t.integer 'expires_in'
    t.datetime 'revoked_at'
    t.datetime 'created_at', null: false
    t.string 'scopes'
    t.string 'previous_refresh_token', default: '', null: false
    t.index ['application_id'], name: 'index_oauth_access_tokens_on_application_id'
    t.index ['refresh_token'], name: 'index_oauth_access_tokens_on_refresh_token', unique: true
    t.index ['resource_owner_id'], name: 'index_oauth_access_tokens_on_resource_owner_id'
    t.index ['token'], name: 'index_oauth_access_tokens_on_token', unique: true
  end

  create_table 'oauth_applications', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'uid', null: false
    t.string 'secret', null: false
    t.text 'redirect_uri', null: false
    t.string 'scopes', default: '', null: false
    t.boolean 'confidential', default: true, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['uid'], name: 'index_oauth_applications_on_uid', unique: true
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'title'
    t.string 'body'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'user_id'
    t.index ['user_id'], name: 'index_questions_on_user_id'
  end

  create_table 'social_auths', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'provider'
    t.string 'uid'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_social_auths_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'name', default: '', null: false
    t.boolean 'admin', default: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'avatar'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'votes', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'votesable_type'
    t.bigint 'votesable_id'
    t.string 'vote'
    t.integer 'votesable_parent_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_votes_on_user_id'
    t.index ['votesable_parent_id'], name: 'index_votes_on_votesable_parent_id'
    t.index %w[votesable_type votesable_id], name: 'index_votes_on_votesable'
  end

  add_foreign_key 'oauth_access_grants', 'oauth_applications', column: 'application_id'
  add_foreign_key 'oauth_access_grants', 'users', column: 'resource_owner_id'
  add_foreign_key 'oauth_access_tokens', 'oauth_applications', column: 'application_id'
  add_foreign_key 'oauth_access_tokens', 'users', column: 'resource_owner_id'
  add_foreign_key 'social_auths', 'users'
end
