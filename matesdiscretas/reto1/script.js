var theInd = document.getElementById("anIndicator");
var theState = false;

function toggleState(){
    switch (theState){
        case true: 
            theInd.style.color = "red";
        break;
        case false: 
            theInd.style.color = "blue";
        break;
    }
    theState = !theState;
    //console.log(theState);
}
setInterval(toggleState, 200);


var totalNumber = Number(prompt("¿Hasta qué número?","1000"));
var delayTime = Number(prompt("¿Delay entre coloreo?","50"));
const container = document.getElementById("table-container");
var boxArray = [];

for(let i=1; i<=totalNumber; i++){
    const casilla = document.createElement('div');
    casilla.textContent = i;
    casilla.classList.add("boxy");
    casilla.classList.add(i);
    container.appendChild(casilla);
    boxArray.push(false); //Not touched
}

const boxes = document.querySelectorAll('.boxy');
function random256(){
    return Math.floor(Math.random()*256);
}
function sleep(ms) {
   return new Promise(resolve => setTimeout(resolve, ms));
}
function pleaseScrollTo(elementToScrollTo){
    const elementPosition = elementToScrollTo.offsetTop;//elementToScrollTo.getBoundingClientRect().top + window.scrollY;

    // Scroll to the element's position
    window.scrollTo({
      top: elementPosition-window.innerHeight*2/3,
      behavior: 'auto' // You can use 'auto' or 'smooth' for the scrolling behavior
    });
}
pleaseScrollTo(document.getElementById('anIndicator'));
const audioCtx = new (window.AudioContext || window.webkitAudioContext)();
function playAsync(n){
    // Load the second audio file
    eval(`
    const audioFile${n} = './blaster-2-81267.mp3';

    // Create a buffer source for the second audio file
    const audioSource${n} = audioCtx.createBufferSource();

    // Fetch and decode the second audio file
    fetch(audioFile${n})
      .then(response => response.arrayBuffer())
      .then(buffer => audioCtx.decodeAudioData(buffer))
      .then(decodedData => {
        // Set the decoded audio data as the buffer for the second source
        audioSource${n}.buffer = decodedData;

        // Connect the second source to the destination (e.g., speakers)
        audioSource${n}.connect(audioCtx.destination);

        // Start playing the second audio
        audioSource${n}.start();
      })
      .catch(error => {
        console.error('Error loading audio file ${n}:', error);
      }
    );`);
}

async function colorizeBoxes(){
    //await sleep(5000);
    for(let i=2; i<=totalNumber; i++){
        if(!boxArray[i-1]){
            //This boxy is a prime
            console.log(`Prime: ${i}`);
            var choosedColor = `rgb(${random256()},${random256()},${random256()})`;
            boxes[i-1].style.backgroundColor = choosedColor;
            //document.getElementById('shot').play();
            playAsync(i);
            
            //Now looks for all multiples above
            for(let j=i; j<=totalNumber; j+=i){
                if(!boxArray[j-1]){
                    //This is a multiple! Then not a prime
                    await sleep(delayTime);
                    boxes[j-1].style.borderColor = choosedColor;
                    boxArray[j-1] = true; //Not here!!!!
                    pleaseScrollTo(boxes[j-1]);

                }
                //console.log(j);
            }
        }
    }
}
//colorizeBoxes();
//console.log(boxArray);
