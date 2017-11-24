defmodule SecretHandshake do
  @codes ["wink", "double blink", "close your eyes", "jump"]
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    cond do
      code < 1 || code > 31 -> []
      code > 15 ->
        Integer.digits(code, 2)
        |> Enum.slice(1, 5)
        |> Enum.zip(Enum.reverse(@codes))
        |> Enum.filter(fn({status, _code}) -> status == 1 end)
        |> Enum.map(fn({1, code}) -> code end)
      code <= 15 ->
        Integer.digits(code, 2)
        |> Enum.reverse
        |> Enum.zip(@codes)
        |> Enum.filter(fn({status, _code}) -> status == 1 end)
        |> Enum.map(fn({1, code}) -> code end)
    end
    # Integer.digits(code, 2)
  end
end

