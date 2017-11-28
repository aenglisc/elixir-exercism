defmodule RotationalCipher do
  @int_values %{ "A" => 65, "Z" => 90, "a" => 97, "z" => 122 }
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    shift = shift
    |> abs
    |> rem(26)

    text
    |> String.split("", trim: true)
    |> Enum.map(fn x -> shift_char(x, shift, String.match?(x, ~r/[a-zA-Z]/)) end)
    |> Enum.join("")
  end

  defp shift_char(char, _shift, _is_a_letter = false), do: char
  
  defp shift_char(<<aacute::utf8>>, shift, _is_a_letter) do
    cond do
      aacute in @int_values["A"]..@int_values["Z"] -> 
        <<(@int_values["A"] + rem(aacute - @int_values["A"] + shift, 26))::utf8>>
      aacute in @int_values["a"]..@int_values["z"] -> 
        <<(@int_values["a"] + rem(aacute - @int_values["a"] + shift, 26))::utf8>>
    end
  end

end

