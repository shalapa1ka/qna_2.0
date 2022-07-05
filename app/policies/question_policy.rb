# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.admin? || user.author?(record)
  end

  def destroy?
    user.admin? || user.author?(record)
  end

  def index?
    true
  end

  def show?
    true
  end

  def vote?
    !user.author?(record) && !user.voted?(:Question)
  end

  def cancel_vote?
    user.voted?(:Question)
  end

  def answer_cancel_vote?
    user.voted?(:Answer, record.id)
  end

  def subscribe_update?
    record.subscriptions.where(user: user, update_question: true).none?
  end

  def unsubscribe_update?
    !subscribe_update?
  end

  def subscribe_new_answer?
    record.subscriptions.where(user: user, new_answer: true).none?
  end

  def unsubscribe_new_answer?
    !subscribe_new_answer?
  end
end
