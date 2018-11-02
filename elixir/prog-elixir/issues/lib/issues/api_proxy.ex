defmodule Issues.ApiProxy do
  
  @hash [:sha, :sha256]

  def calculate_checksum(hash, text) when hash in @hash do
    :crypto.hash(hash, text) |> Base.encode16 |> String.downcase
  end

  def strip_checksum_from_query(query, checksum) do
    query
    |> String.replace("&checksum=#{checksum}", "")
    |> String.replace("checksum=#{checksum}&", "")
  end

  def convert_to_internal_meetingid(meetingid) do
    :crypto.hash(:sha, meetingid) |> Base.encode16 |> String.downcase
  end

  def param_is_not_empty(params, param) do
    Map.has_key?(params, param) && params[param] != ""
  end
end