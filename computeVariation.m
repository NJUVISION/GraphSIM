function score = computeVariation(coords, K)

% coords: coordinates N*3
% K: K nearest neighbors
% radius: spacing
% score: local variation

    z = single( coords );
    N = size(z, 1);
    
    [idx, dist] = knnsearch( coords, coords( round( linspace(1,N, 100))  ,:), 'k', K,  'distance', 'euclidean');
    radius = max( dist(:, K) );

    [idx, dist] = knnsearch( z, z, 'k', K,  'distance', 'euclidean');
    
    Z{1} = z;
    batch_size = 1000;
    batch_num = ceil( size(z,1) / batch_size);
    
    for i_order = 2:5
        
            z = Z{i_order-1};
            for i_batch = 1:batch_num
                
                        batch_index = (i_batch-1)*batch_size+1: min( i_batch*batch_size, N);  
                        
                        for j =1:length(batch_index)
                                
                                i = batch_index(j);
                                distance = dist(i, 2:end);
                                tmp = exp( -(distance./(radius*0.5) ).^2);

                                if sum(tmp) > 10^-6
                                    weight = tmp./sum(tmp);
                                    zz_batch(j, :) = weight*z( idx(i, 2:end), :);
                                else
                                    zz_batch(j, :)  = z(i, :);
                                end
                                clear weight distance tmp
                        end
                        zz(batch_index,:) = zz_batch;
                        clear zz_batch
            end
            Z{i_order} = zz;
            clear zz;
            score(:, i_order-1) = sum(  (Z{1} - Z{i_order}).^2, 2);
            
    end