# README
# THP - Week 5 - Project 1 - The Gossip Project, les premières views
# François THIOUNN

# Notes & Use :
 -run in commandline from folder : 
 	- bundle install
	- rails db:create |rails db:migrate | rails db:seed
	- rails s
- go to http://localhost:3000 and enjoy ;)
- type in http://localhost:3000/home/:id to go to the hidder url (question 2.4)
	where the id is an existing user id in the database
- team and contact page are bootstrat templates 


# Projet : Création d'un potin
  
1. Introduction
Hello ! Aujourd'hui, on va rajouter une nouvelle fonctionnalité à The Gossip Project ! Tu vas reprendre le projet d'hier et appliquer ce que tu as vu aujourd'hui en mettant à disposition un formulaire pour créer des potins.

2. Le projet
2.1. Bases de données ?
Tu te souviens de ce que tu avais vu sur les bases de données et les validations de models ? Eh bien nous allons voir si tu n'es pas trop rouillé à ce sujet 🔨 Rajoute, dans les models, des validations aux attributs importants (spoiler : quasi tous) de ton application.

On va t'aider pour les validations du model des potins :

la présence du title est obligatoire, ce dernier ne peut pas faire moins de 3 caractères ni plus de 14 caractères
la présence du content est obligatoire
2.2. Création de potin
Cette partie sera la plus longue de la journée, car pour la première fois nous allons te faire jouer avec les controllers de Rails. C'est pas trop tôt ! ♥

À partir de la page d'accueil qui recense tous les potins, l'application va inviter l'utilisateur à enregistrer son propre potin. En cliquant sur un lien, il va se retrouver sur une page contenant un formulaire de création de potin. Ce formulaire va demander le titre du potin, ainsi que son contenu. Une fois soumis, le formulaire va enregistrer le potin en base et l'utilisateur va être redirigé vers la page d'accueil.

Le principe de base est simple, mais nous allons le pimenter en te demandant d'implémenter quelques concepts nouveaux : le helper form_tag de Rails et les alertes.

2.2.1. Préparation des routes, du controller et de la view
Pour créer un potin, il est nécessaire d'avoir un controller gossips contenant les méthodes #new et #create.
Il faut également les routes (en mode REST) qui pointent vers ces 2 méthodes.
Pour finir, il te faut la view qui va afficher le formulaire : gossips/new.html.erb. À noter qu'il n'existe pas de view create.html.erb : la méthode #create renvoie vers l'index.

Je te laisse mettre tout ça en place !
⚠️ Attention ⚠️ on l'a déjà dit mais à partir de maintenant on ne veut que des routes en resources ! Pas de route écrite à la main 👋

2.2.2. Formulaire de création
Maintenant que tu as ta view, et tes méthodes de prêtes, nous allons te demander de faire le formulaire de création de potins dans la view new.html.erb. En Rails, nous pouvons voir 4 types principaux de formulaires :

Les formulaires HTML (on en a parlé dans la ressource)
Les form_tag
Les form_for
Les formulaires via la gem simple_form
Pour cet exercice, nous allons te demander d'utiliser form_tag, très adapté quand on débute. Nos amis de LaunchSchool ont fait un bon tuto sur form_tag, et tu peux checker la doc de form_tag.

Ton formulaire doit demander le title ainsi que le content du potin que tu vas créer. Bien entendu, quand tu valides le formulaire, ce dernier doit partir à la méthode #create de ton controller de potins.

2.2.3. Controller
2.2.3.1. def create
Maintenant que nous avons fait un formulaire qui demande ce que l'on veut récupérer, et qui l'envoie à la méthode #create de notre controller, il faut que ce dernier fasse son taff. Le résultat que l'on veut, en termes d'expérience utilisateur, est le suivant :

L'utilisateur est sur une magnifique page où il doit remplir un formulaire. Il le remplit et le soumet.
De là, 2 cas sont possibles:
Si le contenu du formulaire est accepté et que l'objet est bien créé en base, l'utilisateur est redirigé vers une nouvelle page HTML avec, en haut, un bandeau VERT disant un truc du genre "The super potin was succesfully saved !" (c'est ce qu'on appelle une alerte)
Si le contenu du formulaire est refusé (objet non créé en base, car il manque un champ ou alors le contenu n'est pas valide, etc.), l'utilisateur retourne à nouveau sur la page du formulaire avec, en haut, un bandeau ROUGE disant un truc du genre "Error : you need to complete this field / the title must be at least 3 characters longue / etc." (c'est un autre type d'alerte)
Le boulot de ton controller est d'arriver à coordonner ceci. En gros, il va faire la chose suivante :

Il va récupérer les informations du formulaire et essayer d'en faire une instance de ton model et de la sauver.
le model va soit dire "tout va bien j'ai réussi à créer mon instance 👌"...
… ou alors il va dire "ROLLBACK" "hey ! les validations ne sont pas passées, je te renvoie une ou plusieurs erreurs"
Si l'instance est sauvegardée en base de données, le controller va rediriger vers la page index.
Si le model n'arrive pas à sauvegarder ton instance, il va rester sur la page du formulaire pour que l'utilisateur ré-essaye de le remplir sans erreur.
Pour la création d'une instance, un controller ne fera jamais plus. Rappelle-toi : Fat model Skinny controller. Son taf est de récupérer les informations, d'appeler les bons services, puis de faire les redirections.

Bref, voici le squelette de la méthode #create :

def create
  @gossip = Gossip.new(xxx) # avec xxx qui sont les données obtenues à partir du formulaire

  if @gossip.save # essaie de sauvegarder en base @gossip
    # si ça marche, il redirige vers la page d'index du site
  else
    # sinon, il render la view new (qui est celle sur laquelle on est déjà)
  end
end
Pour info, ce squelette convient à environ 100 % des méthodes #create des controllers de Rails. N'essaie pas de sortir des clous de ce squelette, il y aurait 100 % de chance que ce soit faux 😉. Tout ce que tu veux mettre en plus devra aller dans le model.

⚠️Pour le moment nous ne gérons pas l'authentification des utilisateurs. Or chaque potin doit avoir un auteur en base ! Pour palier à ça, nous allons faire une petite astuce : tu vas créer (en console) un utilisateur nommé anonymous puis faire en sorte que tous les potins créés dans la view new soient systématiquement associés à cet utilisateur.

🤓 QUESTION RÉCURRENTE
Dis donc Jamy, c'est quoi la différence entre redirect_to et render ? Pourquoi je fais l'un et pas l'autre ?
redirect_to va passer par la route sélectionnée, donc ton app repart sur un controller, sa méthode, etc.
Par contre render, ne fait qu'afficher une view tout en gardant les variables disponibles (notamment @gossip). Et ça, ça te permet de faire dans ta view :

<% if @gossip.errors.any? %>
  <p>Nous n'avons pas réussi à créer le potin pour la (ou les) raison(s) suivante(s) :</p>
  <ul>
    <% @gossip.errors.full_messages.each do |message| %>
      <li><%= message %></li>
    <% end %>
  </ul>
<% end %>
Et cela affichera les erreurs que tu as si durement codées dans les validations de tes models 🙌

Et voilà, maintenant on t'invite à remplir le controller et coder ta méthode create pour qu'elle fonctionne.
Pour le moment, n'affiche pas d'alerte d'échec ou de réussite : on cherche juste à sauver en base puis renvoyer vers l'index en cas de succès ou recharger le formulaire en cas d'échec.
Nous te laissons délibérément avec peu d'information, pour que tu cherches un peu sur le net comment tout articuler.

2.2.3.2. Alerte générale
Comme décrit plus haut, les alertes permettent de donner à l'utilisateur l'information qu'un formulaire a été soumis avec succès (un objet a été sauvé en base) ou bien qu'il y a eu un souci (l'utilisateur doit revoir le formulaire).

Commence donc par afficher dans les views des petits messages qui informe l'utilisateur du succès (ou non) de son formulaire.

Une fois que tu as fait cela, essaye d'afficher les messages dans une belle alerte Bootstrap. Maintenant il n'y a plus de doute : l'utilisateur sait quand il a réussi (alerte VERTE) ou quand ça a raté (alerte ROUGE).

3. Rendu attendu
Une amélioration de The Gossip Project : on peut enfin créer un potin sans passer par le seed ni la console !