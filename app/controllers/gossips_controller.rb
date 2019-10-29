require 'colorize'
class GossipsController < ApplicationController
  def new
  end
  def create
    params[:gossip] = Gossip.new(title: params[:gossip_title], content: params[:gossip_content],user: User.find(1))  # avec xxx qui sont les données obtenues à partir du formulaire
    puts "*"*80
    if params[:gossip].save # essaie de sauvegarder en base @gossip
       redirect_to :action => 'show', notice: 'Thank You For Subscribing!'
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      render :action => 'new'
    end
  end
  def show
    params[:gossip_array] = Gossip.all
  end
end
