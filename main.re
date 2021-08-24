open Lwt;
// open Cohttp;
open Cohttp_lwt_unix;
let server = {
  let callback = (_conn, _req, body) =>
    body
    |> Cohttp_lwt.Body.to_string
    >|= (body => Printf.sprintf("Hello! %s", body))
    >>= (body => Server.respond_string(~status=`OK, ~body, ()));

  Server.create(~mode=`TCP(`Port(8000)), Server.make(~callback, ()));
};
let () = (Lwt_main.run(server));
