class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= Usuario.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    elsif user.coordinador?
      can [:manage, :add_usuario, :remove_usuario], Circulo
      can [:read, :create, :update], Usuario, { :id => user.id }
      can [:read], Account, { :usuario_id => user.id }
      can [:read], Compra
    elsif user.usuario?
      can [:read], Compra
      can [:create], Circulo
      can [:read, :create, :update], Usuario, { :id => user.id }
      can [:read, :create, :update], Pedido, { :usuario_id => user.id }
      can [:abandonar_circulo], Usuario
      can [:add_myself_cycle], Usuario
      can [:read], Account, { :usuario_id => user.id }
    elsif user.director?
      can [:read], Circulo, { :warehouse_id => user.usuario_roles.warehouse_id }
      can [:read, :create, :update], Pedido, { :warehouse_id => user.usuario_roles.warehouse_id }
    else
      can [:read], Compra
      can [:read], Warehouse
    end
    # elsif user.coordinador?
    #   can :read, :all
    # elsif user.usuario?
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
