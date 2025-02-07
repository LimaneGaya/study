defmodule Myphoenixapp.Test do
  @endpoint "https://generativelanguage.googleapis.com/v1beta"
  @model "gemini-2.0-flash-lite-preview-02-05"
  @key System.get_env("GEMINI_KEY")
  @stream "streamGenerateContent"

  def testgemini(prompt) do
    Req.post!(
      "#{@endpoint}/models/#{@model}:#{@stream}?key=#{@key}",
      into: &Myphoenixapp.Test.process_response/2,
      body: ~s({"contents":[{"parts":[{"text": "#{prompt}"}]}]})
    )
    :ok
  end

  def process_response({:data, data}, {req, resp}) do

    data = cond do
      String.starts_with?(data, "[") -> String.trim_leading(data, "[")
      String.starts_with?(data, ",") -> String.trim_leading(data, ",")
      String.ends_with?(data, "]") -> String.trim_leading(data, ",")
      true -> data
    end

    if String.trim(data) != "]" do
      JSON.decode!(data)
      |> get_in(["candidates", Access.at(0), "content", "parts", Access.at(0), "text"])
      |> IO.write()
    end

    {:cont, {req, resp}}
  end
end
