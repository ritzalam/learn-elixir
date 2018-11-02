defmodule ApiProxyTest do
  use ExUnit.Case

  alias Issues.ApiProxy, as: Api

  test "calculate sha256 checksum" do
    text = "createname=Demo+Meeting&meetingID=Demo+Meeting&voiceBridge=74972&attendeePW=ap&moderatorPW=mp&isBreakoutRoom=false&record=false3895c0fc987abdd47edf0352fea2a458"
    assert Api.calculate_checksum(:sha256, text) == "81a30be0b00e6e56c12056f868e5be19650b5b80b81602500ec700858e5d9cf4"
  end

  test "remove checksum from beginning" do
    query = "checksum=foo&a=a&b=b"
    assert Api.strip_checksum_from_query(query, "foo") == "a=a&b=b"
  end

  test "remove checksum from end" do
    query = "a=a&b=b&checksum=foo"
    assert Api.strip_checksum_from_query(query, "foo") == "a=a&b=b"
  end

  test "remove checksum from middle" do
    query = "a=a&checksum=foo&b=b"
    assert Api.strip_checksum_from_query(query, "foo") == "a=a&b=b"
  end

  test "param is not empty" do
    params = %{"foo" => "foo", "bar" => "bar", "baz" => "baz"}
    assert Api.param_is_not_empty(params, "foo") == true
  end

  test "param is empty" do
    params = %{"foo" => "", "bar" => "bar", "baz" => "baz"}
    assert Api.param_is_not_empty(params, "foo") == false
  end
end