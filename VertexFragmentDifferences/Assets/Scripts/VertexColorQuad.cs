using UnityEngine;
using System.Collections;

public class VertexColorQuad : MonoBehaviour {

	public Color[] colors;

	// Use this for initialization
	void Start () {
	
		Mesh m = GetComponent<MeshFilter>().mesh;
		m.colors = colors;

	}
	

}
