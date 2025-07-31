// Appel des sélecteurs
const activity = document.getElementById("activity-input");//Texte activité
const time = document.getElementById("time-select");//Moment de l'activité
const addBtn = document.getElementById("add-btn");//Ajouter activité
const suggestBtn = document.getElementById("suggest-btn");//Bouton suggestion Chuck
const filter = document.querySelectorAll("#filters button");//Bouton des filtres
const routine = document.querySelectorAll(".routine-part");//Quand j'appelle les moment pour les filtres 

const chuck = document.getElementById("chuck-icon");

// Fonction pour créer une activité
function addActivity(texte, moment){
    const li = document.createElement("li");
    li.textContent = texte;

    const btnSuppr = document.createElement("button");
    btnSuppr.textContent = "X";
    btnSuppr.style.marginLeft = "10px";
    btnSuppr.style.color ='red';
    btnSuppr.addEventListener("click", () =>{
        li.remove();
    });

    li.appendChild(btnSuppr);

    const ul = document.getElementById(`${moment}-list`);
    ul.appendChild(li);
}

// Ajouter l'activité
addBtn.addEventListener("click", () =>{
    const texte = activity.value.trim();
    const moment = time.value;

    if (texte !== ""){
        addActivity(texte, moment);
        activity.value = "";
    }
});


// Suggestion via API Chuck Norris
suggestBtn.addEventListener('click', async function() {
    try{
        const reponse = await fetch ('https://api.chucknorris.io/jokes/random');

        if(!reponse.ok){
            throw new Error(`Erreur HTTP : ${reponse.status}`);
        }

        const data = await reponse.json();
        //console.log(data);

        if(data.url){
            chuck.style.display = "inline";
            activity.value = data.value;
        } else{
            alert("Erreur lors de la récupération de la citation du Chuck");
        }
    }catch (error){
        console.log('Erreur :', error);
        alert("Une erreur lors de la récupération de la citation du Chuck");
    }
})

// Filtres

filter.forEach((button) =>{ //parcours des boutons
    button.addEventListener("click", () =>{
        const filtre = button.dataset.filter; //Récup de l'attribut de "filter"

        routine.forEach((section) =>{
            if (filtre === "all" || section.dataset.time ===filtre) {
                section.style.display = "block";
            }else {
                section.style.display = "none";
            }
        });
    });
});

//Backgound animé vanta
VANTA.CLOUDS({
    el: "#vanta-bg",
    mouseControls: true,
    touchControls: true,
    gyroControls: false,
    minHeight: 200.00,
    minWidth: 200.00,
    skyColor: 0x133d50,
    sunGlareColor: 0x696969,
    sunlightColor: 0x6e3d0f
})
