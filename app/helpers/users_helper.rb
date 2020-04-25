# frozen_string_literal: true

# Helper methods defined here can be accessed in any controller or view in the application

module Peluchero
  class App
    module UsersHelper
      def toggle_user_role_url(user)
        user.pending_approval? ? url(:users, :promote_to_admin, id: user.id) : url(:users, :demote_to_unauthorized, id: user.id)
      end

      def toggle_user_role_button(user, form)
        if user.pending_approval?
          form.submit 'Autorizar', class: 'btn btn-success'
        else
          form.submit 'Desautorizar', class: 'btn btn-dark'
        end
      end
    end

    helpers UsersHelper
  end
end
