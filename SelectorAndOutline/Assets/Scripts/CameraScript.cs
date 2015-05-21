using UnityEngine;
using System.Collections;

//so that we can see changes we make without having to run the game

[ExecuteInEditMode]
public class CameraScript : MonoBehaviour {
	
	public Material mat;
	public Color edgecolor;
	public float step;
	public bool variation;
	public AnimationCurve anim;

	void Start () {
		camera.depthTextureMode = DepthTextureMode.Depth;
	}
	
	void OnRenderImage (RenderTexture source, RenderTexture destination){

		if(variation){
			mat.SetColor("_edgecolor", anim.Evaluate(Time.timeSinceLevelLoad) * edgecolor);
		}else{
			mat.SetColor("_edgecolor", edgecolor);
		}

		mat.SetFloat("_step", step);

		Graphics.Blit(source,destination,mat);
		//mat is the material which contains the shader
		//we are passing the destination RenderTexture to
	}
}