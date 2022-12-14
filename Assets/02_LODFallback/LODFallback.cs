using UnityEngine;

public class LODFallback : MonoBehaviour
{
    [Tooltip("GlobalLODの値"), SerializeField, Range(100f, 600f)]
    private int ShaderLOD = 600;

    private void OnGUI()
    {
        GUILayout.BeginArea(new Rect(0, 0, 200, 100));

        GUILayout.Label("ShaderLOD :" + this.ShaderLOD);

        this.ShaderLOD = (int)GUILayout.HorizontalSlider(this.ShaderLOD, 0, 600);

        GUILayout.EndArea();

        // Shader.globalMaximumLODですべてのshaderのLODを変更している
        // 特定のshaderのLODを変更したい場合は、Shader.maximumLODを工夫して使う
        Shader.globalMaximumLOD = this.ShaderLOD;
        // shader.maximumLOD;
    }
}