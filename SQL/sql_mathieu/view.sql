SELECT a.title, a.price, c.name
FROM article a
INNER JOIN category c ON a.id_category = c.id;

CREATE VIEW vw_article_category AS (SELECT a.title, a.price, c.name
FROM article a
INNER JOIN category c ON a.id_category = c.id);

/* Exercice 1 Créer la vue suivante :
Elle doit afficher le ticket de caisse avec :
date(created_at -> receipt),
nom et prénom du vendeur(firstname et lastname -> seller),
la liste des produits (title, price -> article) la quantité de produit ajouté(quantity -> article) + calcul du prix X quantité.
 
NB : vous devez group by par id du ticket. Il faut group_concat les articles. 
*/
SELECT 
    s.firstname AS Prénom, s.lastname AS Nom,
    group_concat(concat(a.title, ' - ',a.price, '€ x ', ar.quantity) SEPARATOR ' | ') AS liste_produits,
    SUM(round(a.price * ar.quantity, 2)) AS ticket_total
FROM seller s
INNER JOIN receipt r ON s.id = r.id_seller
INNER JOIN article_receipt ar ON r.id = ar.id_receipt
INNER JOIN article a ON ar.id_article = a.id
GROUP BY r.id, s.firstname, s.lastname;

CREATE VIEW vw_receipt AS (
SELECT 
	concat(s.firstname,' ', s.lastname) AS Vendeur, 
    group_concat(concat(a.title, ' - ',a.price, '€ x ', ar.quantity) SEPARATOR ' | ') AS liste_produits,
    SUM(round(a.price * ar.quantity, 2)) AS ticket_total
FROM seller s
INNER JOIN receipt r ON s.id = r.id_seller
INNER JOIN article_receipt ar ON r.id = ar.id_receipt
INNER JOIN article a ON ar.id_article = a.id
GROUP BY r.id, s.firstname, s.lastname
);

/* Exercice 2 Créer la vue suivante :
Elle doit afficher tous les tickets de caisse avec :
created_at (receipt),
firstname et lastname du vendeur (seller),
le montant ttc du ticket (somme de price (article) X quantity (article_receipt).
*/
SELECT
	r.created_at,
	concat(s.firstname, ' ', s.lastname) AS vendeur,
    sum(a.price * ar.quantity) AS Prix_ttc,
    group_concat('prix ', a.price, '€ ', 'quantité ', ar.quantity SEPARATOR ' | ')
FROM seller s
INNER JOIN receipt r ON s.id = r.id_seller
INNER JOIN article_receipt ar ON r.id = ar.id_receipt
INNER JOIN article a ON ar.id_article = a.id
GROUP BY r.id;