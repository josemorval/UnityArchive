using UnityEngine;
using System.Collections;

public class SelectObject : MonoBehaviour {

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update() {


		if (Input.GetMouseButtonDown (0)) {

			Ray ray;

			ray = GameObject.FindGameObjectWithTag("MainCamera").camera.ScreenPointToRay (Input.mousePosition);

			RaycastHit hit;
			if (Physics.Raycast (ray, out hit, 40f)) 
			{
				//draw invisible ray cast/vector
				GameObject go = hit.collider.gameObject;


				if(go.layer==LayerMask.NameToLayer("Outlineable")){
					go.layer = LayerMask.NameToLayer("Default");
				}else{
					go.layer = LayerMask.NameToLayer("Outlineable");
				}


				
			}

		}
	
	}
}
