const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

signUpButton.addEventListener('click', () => {
	container.classList.add("right-panel-active");
});

signInButton.addEventListener('click', () => {
	container.classList.remove("right-panel-active");
});

function validate()
    {
        var user = document.getElementById("username").value;
        var passw= document.getElementById("password").value;
        
        if(user=="admin" && passw ==123 )
        {
            window.open("admin.html")
        }
        else if(user =="" && passw ==""){
            alert("Username and Password cannot be empty!!")
        }
        
        else {
            alert("Please check crediential and try again")
        }
        
    }