using UnityEngine;

public class MultiCompile : MonoBehaviour
{
    private void OnGUI()
    {
        KeywordToggleGUI("RED");
        KeywordToggleGUI("GREEN");
        KeywordToggleGUI("BLUE");
    }

    private void KeywordToggleGUI(string keyword)
    {
        bool enabled = GUILayout.Toggle(Shader.IsKeywordEnabled(keyword), keyword);

        // 注意点として、個々のシェーダを指定しているわけではないので
        // そのキーワードが定義されているシェーダすべてに影響が出る。
        if (enabled)
        {
            // shaderのキーワードを有効にして、出力結果を変更している
            Shader.EnableKeyword(keyword);
        }
        else
        {
            // shaderのキーワードを無効にしている
            Shader.DisableKeyword(keyword);
        }
    }
}